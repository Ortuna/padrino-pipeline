module Padrino
  module Pipeline
    module Common

      def app_root
        @app.settings.root
      end

      def js_assets
        @config.js_assets
      end

      def css_assets
        @config.css_assets 
      end

      def image_assets
        @config.image_assets 
      end

      def serve_compressed?
        @config.enable_compression || PADRINO_ENV == "production"
      end
    end
  end
end
