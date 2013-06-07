require File.join(File.dirname(__FILE__), 'mini_shoulda')
require File.join(File.dirname(__FILE__), '..' , 'fixtures', 'sprockets_app', 'sprockets_app')

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

  def fixture_path(fixture)
    test_path = File.expand_path(File.dirname(__FILE__) + '/..')
    "#{test_path}/fixtures/#{fixture}" 
  end
end

module Webrat
  module Logging
    def logger # @private
      @logger = nil
    end
  end
end

def pipelines
  [Padrino::Assets::Sprockets]#, Padrino::Assets::AssetPack]
end


