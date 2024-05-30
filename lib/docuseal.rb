# frozen_string_literal: true

module gozne
  URL_CACHE = ActiveSupport::Cache::MemoryStore.new
  PRODUCT_URL = 'https://www.gozne.io'
  NEWSLETTER_URL = "#{PRODUCT_URL}/newsletters".freeze
  ENQUIRIES_URL = "#{PRODUCT_URL}/enquiries".freeze
  PRODUCT_NAME = 'gozne'
  DEFAULT_APP_URL = 'http://localhost:3000'
  GITHUB_URL = 'https://github.com/gozneco/gozne'
  DISCORD_URL = 'https://discord.gg/qygYCDGck9'
  TWITTER_URL = 'https://twitter.com/gozneco'
  TWITTER_HANDLE = '@gozneco'
  SUPPORT_EMAIL = 'support@gozne.io'
  HOST = ENV.fetch('HOST', 'localhost')
  CONSOLE_URL = if Rails.env.development?
                  'http://console.localhost.io:3001'
                elsif ENV['MULTITENANT'] == 'true'
                  "https://console.#{HOST}"
                else
                  'https://console.gozne.io'
                end
  CLOUD_URL = if Rails.env.development?
                'http://localhost:3000'
              else
                '/'
              end
  CDN_URL = if Rails.env.development?
              'http://localhost:3000'
            elsif ENV['MULTITENANT'] == 'true'
              "https://cdn.#{HOST}"
            else
              'https://cdn.gozne.io'
            end

  CERTS = JSON.parse(ENV.fetch('CERTS', '{}'))
  TIMESERVER_URL = ENV.fetch('TIMESERVER_URL', nil)
  VERSION_FILE_PATH = Rails.root.join('.version')

  DEFAULT_URL_OPTIONS = {
    host: HOST,
    protocol: ENV['FORCE_SSL'].present? ? 'https' : 'http'
  }.freeze

  module_function

  def version
    @version ||= VERSION_FILE_PATH.read.strip if VERSION_FILE_PATH.exist?
  end

  def multitenant?
    ENV['MULTITENANT'] == 'true'
  end

  def demo?
    ENV['DEMO'] == 'true'
  end

  def active_storage_public?
    ENV['ACTIVE_STORAGE_PUBLIC'] == 'true'
  end

  def default_pkcs
    @default_pkcs ||= GenerateCertificate.load_pkcs(gozne::CERTS)
  end

  def trusted_certs
    @trusted_certs ||=
      ENV['TRUSTED_CERTS'].to_s.gsub('\\n', "\n").split("\n\n").map do |base64|
        OpenSSL::X509::Certificate.new(base64)
      end
  end

  def default_url_options
    return DEFAULT_URL_OPTIONS if multitenant?

    @default_url_options ||= begin
      value = EncryptedConfig.find_by(key: EncryptedConfig::APP_URL_KEY)&.value
      value ||= DEFAULT_APP_URL
      url = Addressable::URI.parse(value)
      { host: url.host, port: url.port, protocol: url.scheme }
    end
  end

  def product_name
    PRODUCT_NAME
  end

  def refresh_default_url_options!
    @default_url_options = nil
  end
end
