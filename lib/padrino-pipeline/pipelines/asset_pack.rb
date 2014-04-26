require 'padrino-pipeline/pipelines/base'

module Padrino
  module Pipeline
    class AssetPack < Base
      REQUIRED_LIBRARIES = { 'sinatra-assetpack' => ['sinatra/assetpack'] }

      def packages
        @config.packages  || []
      end

      private

      def require_libraries
        super
        require 'padrino-pipeline/ext/asset-pack/helpers'
      end

      def setup_enviroment
        @app.set :serve_assets, true
        @app.register Sinatra::AssetPack
      end

      def setup_pipeline
        js_prefix, css_prefix, image_prefix, font_prefix = @config.js_prefix, @config.css_prefix, @config.image_prefix, @config.font_prefix
        js_assets, css_assets, image_assets, font_assets = @config.js_assets, @config.css_assets, @config.image_assets, @config.font_assets
        packages            = self.packages
        compression_enabled = @config.serve_compressed?

        @app.assets do
          def mount_asset(prefix, assets)
            [*assets].flatten.each do |asset|
              serve(prefix, :from => asset) if File.exists? asset
            end
          end

          mount_asset(js_prefix,    js_assets)
          mount_asset(css_prefix,   css_assets)
          mount_asset(image_prefix, image_assets)
          mount_asset(font_prefix,  font_assets)

          packages.each { |package| send(package.shift, *package) }
          if compression_enabled
            js_compression  :jsmin
            css_compression :sass
          end
        end 
      end
    end
  end
end
