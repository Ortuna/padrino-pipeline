require 'sinatra/assetpack'

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

      def js_prefix
        (@config.prefix || '') + (@config.js_prefix  || '/assets/javascripts')
      end

      def css_prefix 
        (@config.prefix || '') + (@config.css_prefix || '/assets/stylesheets')
      end

      def setup_pipeline
        @app.instance_eval do
          assets { |pack_config|
            
            serve pack_config.app.js_prefix,  from: 'app/js'
            serve css_prefix, from: 'app/css'

            # The second parameter defines where the compressed version will be served.
            # (Note: that parameter is optional, AssetPack will figure it out.)
            js :app, '/js/app.js', [
              '/js/vendor/**/*.js',
              '/js/lib/**/*.js'
            ]

            css :application, '/css/application.css', [
              '/css/screen.css'
            ]

            js_compression  :uglify
            css_compression :simple   # :simple | :sass | :yui | :sqwish
          }
        end
      end
    end
  end
end
