module Sprockets
  class Environment
    attr_accessor :js_prefix, :css_prefix, :prefix
    @js_prefix  = nil
    @css_prefix = nil
    @prefix     = nil
  end
end
