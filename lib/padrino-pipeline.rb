require 'padrino-pipeline/configuration'

module Padrino
  ##
  # Add public api docs here
  module Pipeline
    
    def configure_assets(&block)
      config = Padrino::Pipeline::Configuration.new(self)
      require_pipeline(config, &block)
      config.pipeline = resolve_pipeline(config.pipeline, config)
      set :pipeline, config
    end

    def require_pipeline(config, &block)
      yield config if block_given?
    rescue NameError => e
      raise if @_tried
      @_tried = true
      klass = e.message.scan(/constant (.*)/).flatten.first
      filename = Padrino::Pipeline.pipelines.invert[klass]
      require "padrino-pipeline/pipelines/#{filename}"
      require "padrino-pipeline/compilers/#{filename}"
      retry
    end

    def resolve_pipeline(pipeline, config)
      pipeline_name = pipeline
      pipeline = Padrino::Pipeline.pipelines[pipeline] if pipeline.kind_of?(Symbol)
      pipeline = pipeline.constantize if pipeline.kind_of?(String)
      fail "#{pipeline_name} pipeline is not registered" unless pipeline.respond_to?(:new)
      pipeline.new(self, config)
    end

    def self.register(name, klass)
      pipelines[name] = klass
    end

    def self.pipelines
      @pipelines ||= {}
    end
  end
end

Padrino::Pipeline.register :sprockets, 'Padrino::Pipeline::Sprockets'
Padrino::Pipeline.register :asset_pack, 'Padrino::Pipeline::AssetPack'
