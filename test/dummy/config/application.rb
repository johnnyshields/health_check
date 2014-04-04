require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Dummy
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.secret_token = 'dummy'
    config.secret_key_base = 'foobar'
    config.session_store :cookie_store, key: '_dummy_session'
    config.cache_classes = true
    config.eager_load = false
    config.serve_static_assets = true
    config.static_cache_control = "public, max-age=3600"
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection = false
    config.action_mailer.delivery_method = :test
    config.active_support.deprecation = :stderr
  end
end
