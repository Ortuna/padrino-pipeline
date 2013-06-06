require 'padrino-assets/pipelines/sprockets'
require 'padrino-assets/pipelines/asset_pack'
require 'ostruct'

module Padrino
  ##
  # Add public api docs here
  module Assets

    def configure_assets(&block)
      assets = OpenStruct.new
      yield assets if block_given?
      assets.pipeline.new(self, assets)
    end

  end
end
