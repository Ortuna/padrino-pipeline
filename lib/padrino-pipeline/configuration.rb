module Padrino
  module Pipeline
    class Configuration

      attr_accessor :pipeline,   :packages,  :prefix 
      attr_accessor :css_prefix, :js_prefix, :image_prefix 
      attr_accessor :css_assets, :js_assets, :image_assets
      attr_accessor :enable_compression

      def initialize
        @packages = []
      end

    end
  end
end
