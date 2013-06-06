require 'padrino-assets/sprockets/sprockets'
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
