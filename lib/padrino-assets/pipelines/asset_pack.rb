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

        @app.assets {
          serve js_prefix,  :from => '/assets/javascripts'
          serve css_prefix, :from => '/assets/stylesheets'

          js :application, '/assets/javascripts/application.js', ['/assets/javascripts/*.js']

          js_compression  :uglify
          css_compression :simple
        }
      end
    end
  end
end
