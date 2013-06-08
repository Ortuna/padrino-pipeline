require 'sinatra/assetpack' unless defined? Sinatra::AssetPack

module Padrino
  module Assets
    class AssetPack
      def initialize(app, config)
        @app    = app
        @config = config
        setup_enviroment
        setup_pipeline
      end

      private
      def setup_enviroment
        @app.set :serve_assets, true
        @app.register Sinatra::AssetPack
      end

      def setup_pipeline
        js_prefix  = (@config.prefix || '') + (@config.js_prefix  || '/assets/javascripts')
        css_prefix = (@config.prefix || '') + (@config.css_prefix || '/assets/stylesheets')

        js_assets   = @config.js_assets || 'assets/javascripts'
        css_assets  = @config.css_assets || 'assets/stylesheets'
        packages    = @config.packages  || []

        @app.assets {
          serve js_prefix, :from => js_assets
          serve css_prefix,:from => css_assets

          packages.each do |package|
            send(package.shift, *package) 
          end

          js_compression  :uglify
          css_compression :simple
        }
      end
    end
  end
end
