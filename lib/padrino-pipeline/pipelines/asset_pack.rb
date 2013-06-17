require 'sinatra/assetpack' unless defined? Sinatra::AssetPack
require 'padrino-pipeline/pipelines/common'

module Padrino
  module Pipeline
    class AssetPack
      include Padrino::Pipeline::Common

      def initialize(app, config)
        @app    = app
        @config = config
        setup_enviroment
        setup_pipeline
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
        js_prefix, css_prefix, image_prefix = @config.js_prefix, @config.css_prefix, @config.image_prefix
        js_assets, css_assets, image_assets = @config.js_assets, @config.css_assets, @config.image_assets
        packages            = self.packages
        compression_enabled = serve_compressed?

        @app.assets {
          def mount_asset(prefix, assets)
            if assets.respond_to?(:each)
              assets.each {|asset| serve prefix, :from => asset} 
            else
              serve prefix, :from => assets
            end
          end

          mount_asset js_prefix,    js_assets
          mount_asset css_prefix,   css_assets
          mount_asset image_prefix, image_assets

          packages.each { |package| send(package.shift, *package) }
          if compression_enabled
            js_compression  :uglify
            css_compression :sass
          end
        }
      end
    end
  end
end
