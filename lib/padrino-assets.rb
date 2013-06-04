module Padrino
  ##
  # Add public api docs here
  module Assets
    class << self
      def registered(app)
        require_dependencies
        #TODO: Extract to class
        setup_sprockets_enviroment  app
        setup_sprockets_javascript  app
        setup_sprockets_stylesheets app
      end

      alias :included :registered
      def setup_sprockets_stylesheets(app)
        app.settings.assets.append_path File.join(app.settings.root, 'assets', 'stylesheets')
        app.settings.assets.css_prefix     = '/assets/stylesheets'
        app.send(:mount_css_assets, app.settings.assets.css_prefix)
      end

      def setup_sprockets_javascript(app)
        app.settings.assets.append_path File.join(app.settings.root, 'assets', 'javascripts')
        app.settings.assets.js_prefix      = '/assets/javascripts'
        app.settings.assets.js_compressor  = Uglifier.new(:mangle => true)
        app.send(:mount_js_assets,  app.settings.assets.js_prefix)
      end

      def setup_sprockets_enviroment(app)
        app.set :serve_assets, true
        app.set :assets, Sprockets::Environment.new
      end

      def require_dependencies
        require 'sprockets'
        require 'uglifier'
        require 'padrino-assets/ext/sprockets/environment'
      end
    end #class << self

    def configure_assets(&block)
      original_js_prefix  = assets.js_prefix
      original_css_prefix = assets.css_prefix

      yield assets if block_given?
      mount_js_assets(assets.js_prefix)   unless original_js_prefix  == assets.js_prefix
      mount_css_assets(assets.css_prefix) unless original_css_prefix == assets.css_prefix
    end

    private
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

      get "#{prefix}/:file.#{extension}" do
        content_type(content_type)
        settings.assets["#{params[:file]}.#{extension}"] || not_found
      end
    end
  end
end
