module Padrino
  module Pipeline
    class Base
      def initialize(app, config)
        require_libraries
        @app    = app
        @config = config
        setup_enviroment
        setup_pipeline
      end

      ##
      # Should be overridden by the implementation.
      def require_libraries
      end

      ##
      # Should be overridden by the implementation.
      def setup_enviroment
      end

      ##
      # Should be overridden by the implementation.
      def setup_pipeline
      end
    end
  end
end
