module Padrino
  module Pipeline
    class Configuration

      attr_accessor :pipeline,   :packages,  :prefix 
      attr_accessor :css_prefix, :js_prefix, :image_prefix 
      attr_accessor :css_assets, :js_assets, :image_assets
      attr_accessor :js_compiled_output, :css_compiled_output, :compiled_output
      attr_accessor :js_compiled_asset,  :css_compiled_asset
      attr_accessor :enable_compression, :app

      def initialize(app)
        @app          = app
        @packages     = []
        @image_prefix = '/assets/images'
        @js_prefix    = '/assets/javascripts'
        @css_prefix   = '/assets/stylesheets'

        @image_assets = "#{app_root}/assets/images"
        @js_assets    = "#{app_root}/assets/javascripts"
        @css_assets   = "#{app_root}/assets/stylesheets"

        @compiled_output     = "#{app_root}/public"
        @js_compiled_output  = "javascripts"
        @css_compiled_output = "stylesheets"

        @js_compiled_asset  = 'application.js'
        @css_compiled_asset = 'application.css'
      end

      def compile(*args)
        asset_compiler.compile(*args)
      end

      def clean(*args)
        asset_compiler.clean(*args)
      end

      def app_root
        @app.settings.root
      end

      def image_prefix
        "#{prefix || ''}#{@image_prefix}"
      end

      def js_prefix
        "#{prefix || ''}#{@js_prefix}"
      end

      def css_prefix
        "#{prefix || ''}#{@css_prefix}"
      end

      def serve_compressed?
        env = (defined?(PADRINO_ENV) && PADRINO_ENV) || (defined?(RAKE_ENV) && RAKE_ENV)
        enable_compression || env == "production"
      end
      
      def asset_compiler
        @asset_compiler ||= match_compiler.new(self)
      end

      private
      def pipeline_class 
        @pipeline.class.name
      end

      def match_compiler
        pipeline_type  = pipeline_class.split('::').last
        "Padrino::Pipeline::Compiler::#{pipeline_type}".constantize
      end
    end
  end
end
