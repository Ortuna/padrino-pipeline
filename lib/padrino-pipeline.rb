require 'padrino-pipeline/pipelines/sprockets'
require 'padrino-pipeline/pipelines/asset_pack'
require 'padrino-pipeline/compilers/sprockets'
require 'padrino-pipeline/compilers/asset_pack'

require 'padrino-pipeline/configuration'

module Padrino
  ##
  # Add public api docs here
  module Pipeline
    
    def configure_assets(&block)
      config = Padrino::Pipeline::Configuration.new(self)
      yield config if block_given?
      config.pipeline = config.pipeline.new(self, config)
      set :pipeline, config
    end

  end
end
