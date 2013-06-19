require 'padrino-helpers'

module Padrino
  module Helpers
    module AssetTagHelpers

      def pipeline_asset_path(kind, source)
        original_asset_path(kind, source)
      end

      alias_method :original_asset_path, :asset_path
      alias_method :asset_path, :pipeline_asset_path

    end #AssetTagHelpers
  end #Helpers
end #Padrino
