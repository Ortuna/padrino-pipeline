module Padrino
  module Pipeline
    class Configuration

      attr_accessor :pipeline,   :packages,  :prefix 
      attr_accessor :css_prefix, :js_prefix, :image_prefix 
      attr_accessor :css_assets, :js_assets, :image_assets
      attr_accessor :enable_compression

      def initialize(app)
        @app          = app
        @packages     = []
        @image_prefix = '/assets/images'
        @js_prefix    = '/assets/javascripts'
        @css_prefix   = '/assets/stylesheets'

        @image_assets = "#{app_root}/assets/images"
        @js_assets    = "#{app_root}/assets/javascripts"
        @css_assets   = "#{app_root}/assets/stylesheets"
      end

      def app_root
        @app.settings.root
      end

      def image_prefix
        (prefix || '') + @image_prefix
      end

      def js_prefix
        (prefix || '') + @js_prefix
      end

      def css_prefix
        (prefix || '') + @css_prefix
      end

      def serve_compressed?
        enable_compression || PADRINO_ENV == "production"
      end

    end
  end
end
