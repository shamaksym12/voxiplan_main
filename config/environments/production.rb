Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.force_ssl = true

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = Uglifier.new(harmony: true, compress: { unused: false })
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true

  # `config.assets.precompile` and `config.assets.version` have moved to config/initializers/assets.rb

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Mount Action Cable outside main process or domain
  # config.action_cable.mount_path = nil
  # config.action_cable.url = 'wss://example.com/cable'
  # config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "voxiplan_#{Rails.env}"
  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = { :host => Rails.application.secrets.host }

  # TODO: Test email sending
  config.action_mailer.smtp_settings = {
      :address   => "smtp.sendgrid.net",
      :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
      :enable_starttls_auto => true, # detects and uses STARTTLS
      :user_name => ENV["SENDGRID_USERNAME"],
      :password  => ENV["SENDGRID_PASSWORD"], # SMTP password is any valid API key, when user_name is "apikey".
      :authentication => 'login',
      :domain => 'yourdomain.com', # your domain to identify your server when connecting
  }

  config.paperclip_defaults = {
     storage: :s3,
     bucket: ENV["SPACE_BUCKET_NAME"],
     s3_credentials: {
       access_key_id: ENV["SPACE_KEY"],
       secret_access_key: ENV["SPACE_SECRET"]
     },
     s3_host_name: ENV["SPACE_HOSTNAME"],
     s3_host_alias: "#{ENV["SPACE_BUCKET_NAME"]}.#{ENV["SPACE_HOSTNAME"]}",
     s3_region: ENV["SPACE_REGION"],
     s3_protocol: :https,
     s3_options: {
       endpoint: "https://#{ENV["SPACE_HOSTNAME"]}",
     },
     url: ":s3_alias_url",
     path: "/assets/:class/:attachment/:style/:filename",
   }

  config.cache_store = :mem_cache_store,
    (ENV["MEMCACHEDCLOUD_SERVERS"] || "").split(","),
    {:username => ENV["MEMCACHEDCLOUD_USERNAME"],
     :password => ENV["MEMCACHEDCLOUD_PASSWORD"],
     :failover => true
    }

  # config.paperclip_defaults = {
  #     storage: :s3,
  #     s3_host_name: ENV.fetch('SPACE_ENDPOINT'),
  #     bucket: ENV.fetch('SPACE_BUCKET_NAME'),
  #     s3_credentials: {
  #         access_key_id: ENV.fetch('SPACE_KEY'),
  #         secret_access_key: ENV.fetch('SPACE_SECRET'),
  #         s3_region: ENV.fetch('SPACE_REGION'),
  #     }
  # }
end
