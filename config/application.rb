require File.expand_path('../boot', __FILE__)


require 'yaml'
YAML::ENGINE.yamler= 'syck'
require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Germanize
  class Application < Rails::Application
    config.autoload_paths << "#{config.root}/lib"
    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.integration_tool :rspec
    end

    config.i18n.default_locale = :de

    config.action_view.javascript_expansions[:defaults] = %w(jquery.js rails.js)

    config.encoding = "utf-8"

    config.filter_parameters += [:password]
  end
end
