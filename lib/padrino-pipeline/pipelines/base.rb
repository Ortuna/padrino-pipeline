module Padrino
  module Pipeline
    class Base
      ##
      # An Array or a Hash of libraries to require for pipeline to work.
      # Format: ['gem1', 'gem2'] or { 'gem1' => ['feature1', 'feature2'] }
      #
      # Examples:
      #   REQUIRED_LIBRARIES = { 'sinatra-assetpack' => 'sinatra/assetpack' }
      #   REQUIRED_LIBRARIES = %w[sprockets uglifier]
      #
      REQUIRED_LIBRARIES = {}

      def initialize(app, config)
        require_libraries
        @app    = app
        @config = config
        setup_enviroment
        setup_pipeline
      end

      private

      def require_libraries
        self.class::REQUIRED_LIBRARIES.each do |gem,features|
          Array(features||gem).each{ |feature| require feature }
        end
      rescue LoadError
        message = self.class::REQUIRED_LIBRARIES.inject("Please, add these to your app Gemfile:\n") do |all,(gem,features)|
          all << "gem '#{gem}'\n"
        end
        defined?(logger) ? logger.error(message) : warn(message)
        raise
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
