require 'padrino-helpers'

module Padrino
  module Helpers
    module AssetTagHelpers

      def pipeline_asset_folder_name(kind)
        pipeline = settings.pipeline
        case kind
        when :css    then pipeline.css_prefix
        when :js     then pipeline.js_prefix
        when :images then pipeline.image_prefix
        else kind.to_s
        end
      end

      alias_method :original_asset_folder_name, :asset_folder_name
      alias_method :asset_folder_name, :pipeline_asset_folder_name

    end #AssetTagHelpers
  end #Helpers
end #Padrino
