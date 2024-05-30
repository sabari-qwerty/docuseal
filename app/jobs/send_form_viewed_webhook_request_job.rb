# frozen_string_literal: true

class SendFormViewedWebhookRequestJob < ApplicationJob
  queue_as :webhooks

  USER_AGENT = 'gozne.io Webhook'

  MAX_ATTEMPTS = 10

  def perform(submitter, params = {})
    attempt = params[:attempt].to_i
    url = Accounts.load_webhook_url(submitter.submission.account)

    return if url.blank?

    preferences = Accounts.load_webhook_preferences(submitter.submission.account)

    return if preferences['form.viewed'] == false

    ActiveStorage::Current.url_options = gozne.default_url_options

    resp = begin
      Faraday.post(url,
                   {
                     event_type: 'form.viewed',
                     timestamp: Time.current,
                     data: Submitters::SerializeForWebhook.call(submitter)
                   }.to_json,
                   'Content-Type' => 'application/json',
                   'User-Agent' => USER_AGENT)
    rescue Faraday::Error
      nil
    end

    if (resp.nil? || resp.status.to_i >= 400) && attempt <= MAX_ATTEMPTS &&
       (!gozne.multitenant? || submitter.account.account_configs.exists?(key: :plan))
      SendFormViewedWebhookRequestJob.set(wait: (2**attempt).minutes)
                                     .perform_later(submitter, {
                                                      attempt: attempt + 1,
                                                      last_status: resp&.status.to_i
                                                    })
    end
  end
end
