require 'padrino-helpers'

module Padrino
  module Helpers
    module AssetTagHelpers

      def pipeline_asset_folder_name(kind)
        config = settings.pipeline_config
        case kind
        when :css    then config.css_prefix
        when :js     then config.js_prefix
        when :images then config.image_prefix
        else kind.to_s
        end
      end

      alias_method :original_asset_folder_name, :asset_folder_name
      alias_method :asset_folder_name, :pipeline_asset_folder_name

    end #AssetTagHelpers
  end #Helpers
end #Padrino
