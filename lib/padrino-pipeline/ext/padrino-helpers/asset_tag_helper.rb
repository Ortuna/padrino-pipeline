require 'padrino-helpers'

module Padrino
  module Helpers
    module AssetTagHelpers

      def pipeline_asset_folder_name(kind)
        case kind
        when :css then 'stylesheets'
        when :js  then 'javascripts'
        else kind.to_s
        end
      end

      alias_method :original_asset_folder_name, :asset_folder_name
      alias_method :asset_folder_name, :pipeline_asset_folder_name

    end #AssetTagHelpers
  end #Helpers
end #Padrino
