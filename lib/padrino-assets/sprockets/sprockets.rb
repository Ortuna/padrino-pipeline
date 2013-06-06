require 'sprockets'
require 'uglifier'
require 'padrino-assets/ext/sprockets/environment'
require 'padrino-assets/ext/padrino-helpers/asset_tag_helper'

module Padrino
  module Assets
    class Sprockets
      def initialize(app, assets)
        @app      = app
        @settings = assets
        setup_enviroment
        assets.paths.each { |path| @app.settings.assets.append_path path }
        mount_js_assets  (assets.prefix || '') + (assets.js_prefix  || '/assets/javascripts')
        mount_css_assets (assets.prefix || '') + (assets.css_prefix || '/assets/stylesheets')
      end

      private
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
