module Padrino
  module Assets
    class Setup
      def initialize(app)
        @app = app
        setup_sprockets_enviroment
        setup_sprockets_javascript
        setup_sprockets_stylesheets
      end

      private
      def setup_sprockets_stylesheets(app = @app)
        app.settings.assets.append_path File.join(app.settings.root, 'assets', 'stylesheets')
        app.settings.assets.css_prefix     = '/assets/stylesheets'
        app.send(:mount_css_assets, app.settings.assets.css_prefix)
      end

      def setup_sprockets_javascript(app = @app)
        app.settings.assets.append_path File.join(app.settings.root, 'assets', 'javascripts')
        app.settings.assets.js_prefix      = '/assets/javascripts'
        app.send(:mount_js_assets,  app.settings.assets.js_prefix)
      end

      def setup_sprockets_enviroment(app = @app)
        app.set :serve_assets, true
        app.set :assets, Sprockets::Environment.new
        app.settings.assets.js_compressor  = Uglifier.new(:mangle => true)
      end
    end
  end
end
