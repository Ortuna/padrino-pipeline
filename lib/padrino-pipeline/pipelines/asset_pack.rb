require 'sinatra/assetpack' unless defined? Sinatra::AssetPack

module Padrino
  module Pipeline
    class AssetPack
      def initialize(app, config)
        @app    = app
        @config = config
        setup_enviroment
        setup_pipeline
      end

      def js_prefix
        (@config.prefix || '') + (@config.js_prefix  || '/assets/javascripts')
      end

      def css_prefix
        (@config.prefix || '') + (@config.css_prefix || '/assets/stylesheets')
      end

      def js_assets
        @config.js_assets || 'assets/javascripts'
      end

      def css_assets
        @config.css_assets || 'assets/stylesheets'
      end

      def packages
        @config.packages  || []
      end

      private
      def setup_enviroment
        @app.set :serve_assets, true
        @app.register Sinatra::AssetPack
      end

      def setup_pipeline
        js_prefix, css_prefix   = self.js_prefix, self.css_prefix
        js_assets, css_assets   = self.js_assets, self.css_assets
        packages                = self.packages

        @app.assets {
          def mount_asset(prefix, assets)
            if assets.respond_to?(:each)
              assets.each {|asset| serve prefix, :from => asset} 
            else
              serve prefix, :from => assets
            end
          end

          mount_asset js_prefix,  js_assets
          mount_asset css_prefix, css_assets

          packages.each { |package| send(package.shift, *package) } 

          js_compression  :uglify
          css_compression :simple
        }
      end
    end
  end
end
