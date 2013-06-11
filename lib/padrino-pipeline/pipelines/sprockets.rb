require 'sprockets'
require 'uglifier'
require 'padrino-pipeline/ext/padrino-helpers/asset_tag_helper'
require 'padrino-pipeline/pipelines/common'

module Padrino
  module Pipeline 
    class Sprockets
      include Padrino::Pipeline::Common

      def initialize(app, config)
        @app       = app
        @config    = config
        setup_paths
        setup_enviroment
        setup_sprockets
      end

      private
      def paths
        js_assets  = @js_assets.kind_of?(Array) ? @js_assets : [@js_assets]
        css_assets = @css_assets.kind_of?(Array) ? @css_assets : [@css_assets]
        js_assets + css_assets
      end

      def setup_sprockets
        paths.each { |path| @app.settings.assets.append_path path }
        mount_js_assets  js_prefix 
        mount_css_assets css_prefix
      end

      def setup_enviroment
        @app.set :serve_assets, true
        @app.set :assets, ::Sprockets::Environment.new
        @app.settings.assets.js_compressor  = Uglifier.new(:mangle => true)
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
        @app.get "#{prefix}/:file.#{extension}" do
          content_type(content_type)
          settings.assets["#{params[:file]}.#{extension}"] || not_found
        end
      end

    end
  end
end
