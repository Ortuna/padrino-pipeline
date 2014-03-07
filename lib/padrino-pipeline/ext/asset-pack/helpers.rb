begin
  require 'sinatra/assetpack/helpers.rb'

  module Sinatra
    module AssetPack
      module Helpers

        alias_method :original_image_path, :image_path
        def image_path(source)
          resolve_path(:images, source)
        end

      end
    end
  end

rescue LoadError

end


