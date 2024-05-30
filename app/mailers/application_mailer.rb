# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'gozne <info@gozne.io>'
  layout 'mailer'

  register_interceptor ActionMailerConfigsInterceptor

  before_action do
    ActiveStorage::Current.url_options = gozne.default_url_options
  end

  def default_url_options
    gozne.default_url_options
  end
end
