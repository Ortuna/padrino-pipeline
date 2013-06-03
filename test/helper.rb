require File.expand_path('../../../load_paths', __FILE__)
require File.join(File.dirname(__FILE__), '..', '..', 'padrino-core', 'test', 'mini_shoulda')
require 'rack/test'
require 'webrat'
require 'padrino-helpers'

class MiniTest::Spec
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat.configure { |config| config.mode = :rack }

  def mock_app(base=Padrino::Application, &block)
    @app = Sinatra.new(base, &block)
    @app.set :logging, false
    @app.set :padrino_logging, false
  end

  def rack_app
    Rack::Lint.new(@app)
  end  
end

module Webrat
  module Logging
    def logger # @private
      @logger = nil
    end
  end
end
