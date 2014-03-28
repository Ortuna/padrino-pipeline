require 'padrino-pipeline/pipelines/base'

module Padrino
  module Pipeline 
    class Sprockets < Base
      REQUIRED_LIBRARIES = %w[sprockets uglifier]

      private

      def paths
        js_assets    = @config.js_assets.kind_of?(Array)    ? @config.js_assets    : [@config.js_assets]
        css_assets   = @config.css_assets.kind_of?(Array)   ? @config.css_assets   : [@config.css_assets]
        image_assets = @config.image_assets.kind_of?(Array) ? @config.image_assets : [@config.image_assets]
        js_assets + css_assets + image_assets
      end

      def setup_pipeline
        paths.each { |path| @app.settings.assets.append_path path }
        mount_js_assets    @config.js_prefix 
        mount_css_assets   @config.css_prefix
        mount_image_assets @config.image_prefix
      end

      def setup_enviroment
        @app.set :serve_assets, true
        @app.set :assets, ::Sprockets::Environment.new
        if @config.serve_compressed?
          @app.settings.assets.js_compressor   = Uglifier.new(:mangle => true)
          @app.settings.assets.css_compressor  = :sass
        end
        @app.settings.assets.context_class.class_eval do
          def asset_path(path, options = {})
            path
          end
        end 
      end

      def mount_image_assets(prefix)
        mount_assets(:prefix => prefix)
      end

      def mount_js_assets(prefix)
        mount_assets(:prefix => prefix,
                     :extension => "js",
                     :content_type => "application/javascript")
      end

      def mount_css_assets(prefix)
        mount_assets(:prefix => prefix,
                     :extension => "css",
                     :content_type => "text/css")
      end

      def mount_assets(options = {})
        prefix       = options[:prefix]
        extension    = options[:extension]
        content_type = options[:content_type]
        @app.get "#{prefix}/:path.:ext" do |path, ext|
          return not_found if (extension && ext != extension)
          content_type(content_type || Rack::Mime::MIME_TYPES[".#{ext}"])
          settings.assets["#{path}.#{ext}"] || not_found
        end
      end

    end
  end
end
