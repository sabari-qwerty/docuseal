# frozen_string_literal: true

class SendSubmissionArchivedWebhookRequestJob < ApplicationJob
  queue_as :webhooks

  USER_AGENT = 'gozne.io Webhook'

  MAX_ATTEMPTS = 10

  def perform(submission, params = {})
    attempt = params[:attempt].to_i
    url = Accounts.load_webhook_url(submission.account)

    return if url.blank?

    preferences = Accounts.load_webhook_preferences(submission.account)

    return if preferences['submission.archived'].blank?

    resp = begin
      Faraday.post(url,
                   {
                     event_type: 'submission.archived',
                     timestamp: Time.current,
                     data: submission.as_json(only: %i[id archived_at])
                   }.to_json,
                   'Content-Type' => 'application/json',
                   'User-Agent' => USER_AGENT)
    rescue Faraday::Error
      nil
    end

    if (resp.nil? || resp.status.to_i >= 400) && attempt <= MAX_ATTEMPTS &&
       (!gozne.multitenant? || submission.account.account_configs.exists?(key: :plan))
      SendSubmissionArchivedWebhookRequestJob.set(wait: (2**attempt).minutes)
                                             .perform_later(submission, {
                                                              attempt: attempt + 1,
                                                              last_status: resp&.status.to_i
                                                            })
    end
  end
end
