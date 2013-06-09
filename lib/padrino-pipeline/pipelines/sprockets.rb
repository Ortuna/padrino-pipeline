require 'sprockets'
require 'uglifier'
require 'padrino-pipeline/ext/padrino-helpers/asset_tag_helper'

module Padrino
  module Pipeline 
    class Sprockets
      def initialize(app, config)
        @app       = app
        @config    = config
        setup_paths
        setup_enviroment
        setup_sprockets
      end

      private
      def setup_paths
        @js_assets  = @config.js_assets  || "#{app_root}/assets/javascripts"
        @css_assets = @config.css_assets || "#{app_root}/assets/stylesheets"
      end

      def app_root
        @app.settings.root
      end

      def paths
        js_assets = @js_assets.respond_to?(:each) ? @js_assets : [@js_assets]
        css_assets = @css_assets.respond_to?(:each) ? @css_assets : [@css_assets]
        js_assets + css_assets
      end

      def setup_sprockets
        paths.each { |path| @app.settings.assets.append_path path }
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
