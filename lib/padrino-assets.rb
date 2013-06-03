module Padrino
  ##
  # Add public api docs here
  module Assets
    class << self
      def registered(app)
        require 'sprockets'
        require 'uglifier'
        require 'padrino-assets/ext/sprockets/environment'

        app.set :serve_assets, true
        app.set :assets, Sprockets::Environment.new
        app.settings.assets.append_path File.join(app.settings.root, 'assets/javascripts')
        app.settings.assets.js_compressor  = Uglifier.new(mangle: true)
        app.settings.assets.js_prefix      = '/assets/javascripts'

        app.send(:mount_js_assets, app.settings.assets.js_prefix)
      end

      alias :included :registered

      private 

    end #class << self

    def configure_assets(&block)
      prefix_was = assets.js_prefix
      
      yield assets if block_given?
      mount_js_assets(assets.js_prefix) unless prefix_was == assets.js_prefix
    end

    private 
    def mount_js_assets(prefix)
      get "#{prefix}/:file.js" do
        content_type "application/javascript"
        settings.assets["#{params[:file]}.js"] || not_found
      end
    end
  end

end
