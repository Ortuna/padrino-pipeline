module Padrino
  module Assets
    class AssetPack
      def initialize(app, config)
        @app    = app
        @config = config
        # setup_enviroment
        # setup_pipeline
      end
    end
  end
end
