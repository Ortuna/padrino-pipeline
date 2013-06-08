require 'sprockets'
require 'uglifier'
require 'padrino-pipeline/ext/padrino-helpers/asset_tag_helper'

module Padrino
  module Pipeline 
    class Sprockets
      def initialize(app, config)
        @app    = app
        @config = config
        setup_enviroment
        setup_sprockets
      end

      private
      def app_root
        @app.settings.root
      end

      def default_paths
        ["#{app_root}/assets/javascripts", "#{app_root}/assets/stylesheets"]
      end

      def setup_sprockets
        @config.paths ||= default_paths
        @config.paths.each { |path| @app.settings.assets.append_path path }
        mount_js_assets  (@config.prefix || '') + (@config.js_prefix  || '/assets/javascripts')
        mount_css_assets (@config.prefix || '') + (@config.css_prefix || '/assets/stylesheets')
      end

      def setup_enviroment
        @app.set :serve_assets, true
        @app.set :assets, ::Sprockets::Environment.new
        @app.settings.assets.js_compressor  = Uglifier.new(:mangle => true)
      end

      def mount_js_assets(prefix)
        mount_assets(:prefix => prefix, 
                     :extension => "js",
                     :content_type => "application/javascript")
      end

      def mount_css_assets(prefix)
        mount_assets(:prefix => prefix, 
                     :extension => "css",
                     :content_type => "text/css")
      end

      def mount_assets(options = {})
        prefix       = options[:prefix]
        extension    = options[:extension]
        content_type = options[:content_type]
        @app.get "#{prefix}/:file.#{extension}" do
          content_type(content_type)
          settings.assets["#{params[:file]}.#{extension}"] || not_found
        end
      end

    end
  end
end
