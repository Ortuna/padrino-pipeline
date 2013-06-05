require 'padrino-assets/setup'

module Padrino
  ##
  # Add public api docs here
  module Assets
    class << self
      def registered(app)
        require_dependencies
        Padrino::Assets::Setup.new(app)
      end

      alias :included :registered
      def require_dependencies
        require 'sprockets'
        require 'uglifier'
        require 'padrino-assets/ext/sprockets/environment'
      end
    end #class << self

    def configure_assets(&block)
      before_config = resolve_prefixes
      yield assets if block_given?
      after_config  = resolve_prefixes

      update_mount_points before_config, after_config
    end

    private
    def update_mount_points(before_config, after_config)
      prefix = assets.prefix || ''
      [:js, :css].each do |asset|
        next if before_config[asset] == after_config[asset] && before_config[:prefix] == after_config[:prefix]
        send("mount_#{asset.to_s}_assets", prefix + after_config[asset])
      end
    end

    def resolve_prefixes
      {}.tap do |prefixes|
        prefixes[:js]     = assets.js_prefix
        prefixes[:css]    = assets.css_prefix
        prefixes[:prefix] = assets.prefix
      end
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

      get "#{prefix}/:file.#{extension}" do
        content_type(content_type)
        settings.assets["#{params[:file]}.#{extension}"] || not_found
      end
    end
  end
end
