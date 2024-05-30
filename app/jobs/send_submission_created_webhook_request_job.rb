# frozen_string_literal: true

class SendSubmissionCreatedWebhookRequestJob < ApplicationJob
  queue_as :webhooks

  USER_AGENT = 'gozne.io Webhook'

  MAX_ATTEMPTS = 10

  def perform(submission, params = {})
    attempt = params[:attempt].to_i
    url = Accounts.load_webhook_url(submission.account)

    return if url.blank?

    preferences = Accounts.load_webhook_preferences(submission.account)

    return if preferences['submission.created'].blank?

    resp = begin
      Faraday.post(url,
                   {
                     event_type: 'submission.created',
                     timestamp: Time.current,
                     data: Submissions::SerializeForApi.call(submission)
                   }.to_json,
                   'Content-Type' => 'application/json',
                   'User-Agent' => USER_AGENT)
    rescue Faraday::Error
      nil
    end

    if (resp.nil? || resp.status.to_i >= 400) && attempt <= MAX_ATTEMPTS &&
       (!gozne.multitenant? || submission.account.account_configs.exists?(key: :plan))
      SendSubmissionCreatedWebhookRequestJob.set(wait: (2**attempt).minutes)
                                            .perform_later(submission, {
                                                             attempt: attempt + 1,
                                                             last_status: resp&.status.to_i
                                                           })
    end
  end
end
