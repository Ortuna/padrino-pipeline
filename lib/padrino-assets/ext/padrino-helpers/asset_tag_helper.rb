module Padrino
  module Helpers
    module AssetTagHelpers

      alias :original_asset_path :asset_path
      def asset_path(kind, source)
        original_asset_path(kind, source)
      end

    end #AssetTagHelpers
  end #Helpers
end #Padrino
