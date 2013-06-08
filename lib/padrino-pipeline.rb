require 'padrino-pipeline/pipelines/sprockets'
require 'padrino-pipeline/pipelines/asset_pack'
require 'ostruct'

module Padrino
  ##
  # Add public api docs here
  module Pipeline

    def configure_assets(&block)
      assets = OpenStruct.new
      assets.packages = []
      yield assets if block_given?
      assets.pipeline.new(self, assets)
    end

  end
end
