require 'padrino-pipeline/pipelines/sprockets'
require 'padrino-pipeline/pipelines/asset_pack'
require 'padrino-pipeline/ext/padrino-helpers/asset_tag_helper'
require 'padrino-pipeline/configuration'

module Padrino
  ##
  # Add public api docs here
  module Pipeline

    def configure_assets(&block)
      assets = Padrino::Pipeline::Configuration.new(self)
      yield assets if block_given?
      assets.pipeline.new(self, assets)
    end

  end
end
