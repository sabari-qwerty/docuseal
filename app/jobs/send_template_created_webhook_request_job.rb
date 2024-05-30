# frozen_string_literal: true

class SendTemplateCreatedWebhookRequestJob < ApplicationJob
  queue_as :webhooks

  USER_AGENT = 'gozne.io Webhook'

  MAX_ATTEMPTS = 10

  def perform(template, params = {})
    attempt = params[:attempt].to_i
    url = Accounts.load_webhook_url(template.account)

    return if url.blank?

    preferences = Accounts.load_webhook_preferences(template.account)

    return if preferences['template.created'].blank?

    resp = begin
      Faraday.post(url,
                   {
                     event_type: 'template.created',
                     timestamp: Time.current,
                     data: Templates::SerializeForApi.call(template)
                   }.to_json,
                   'Content-Type' => 'application/json',
                   'User-Agent' => USER_AGENT)
    rescue Faraday::Error
      nil
    end

    if (resp.nil? || resp.status.to_i >= 400) && attempt <= MAX_ATTEMPTS &&
       (!gozne.multitenant? || template.account.account_configs.exists?(key: :plan))
      SendTemplateCreatedWebhookRequestJob.set(wait: (2**attempt).minutes)
                                          .perform_later(template, {
                                                           attempt: attempt + 1,
                                                           last_status: resp&.status.to_i
                                                         })
    end
  end
end
