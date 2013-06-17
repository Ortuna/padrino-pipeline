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

      def image_prefix
        (@config.prefix || '') + @config.image_prefix
      end

      def js_prefix
        (@config.prefix || '') + @config.js_prefix
      end

      def css_prefix
        (@config.prefix || '') + @config.css_prefix
      end

      def serve_compressed?
        @config.enable_compression || PADRINO_ENV == "production"
      end
    end
  end
end
