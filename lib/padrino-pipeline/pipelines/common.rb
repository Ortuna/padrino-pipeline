module Padrino
  module Pipeline
    module Common
      
      def app_root
        @app.settings.root
      end

      def setup_paths
        @js_assets  = @config.js_assets  || "#{app_root}/assets/javascripts"
        @css_assets = @config.css_assets || "#{app_root}/assets/stylesheets"
      end

      def js_prefix
        (@config.prefix || '') + (@config.js_prefix  || '/assets/javascripts')
      end

      def css_prefix
        (@config.prefix || '') + (@config.css_prefix || '/assets/stylesheets')
      end

    end
  end
end
