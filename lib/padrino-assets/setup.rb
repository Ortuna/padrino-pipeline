module Padrino
  module Assets
    class Setup
      def initialize(app)
        @app = app
        setup_sprockets_enviroment
        setup_sprockets_javascripts
        setup_sprockets_stylesheets
      end

      private
      def setup_sprockets_stylesheets(app = @app)
        setup_sprockets_asset(@app, :extension => 'css', :target => 'stylesheets')
      end

      def setup_sprockets_javascripts
        setup_sprockets_asset(@app, :extension => 'js', :target => 'javascripts')
      end

      def setup_sprockets_asset(app = @app, options = {})
        extension = options[:extension]
        target    = options[:target]

        app.settings.assets.append_path File.join(app.settings.root, 'assets', target)
        app.settings.assets.send("#{extension}_prefix=", "/assets/#{target}")

        prefix = app.settings.assets.send("#{extension}_prefix")
        app.send("mount_#{extension}_assets",  prefix)
      end

      def setup_sprockets_enviroment(app = @app)
        app.set :serve_assets, true
        app.set :assets, Sprockets::Environment.new
        app.settings.assets.js_compressor  = Uglifier.new(:mangle => true)
      end
    end
  end
end
