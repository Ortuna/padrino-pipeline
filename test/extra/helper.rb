require File.join(File.dirname(__FILE__), 'mini_shoulda')
require File.join(File.dirname(__FILE__), '..' , 'fixtures', 'sprockets_app', 'sprockets_app')

require 'rack/test'
require 'padrino-helpers'

class MiniTest::Spec
  include Rack::Test::Methods
  
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

MiniTest::Spec.class_eval do
  def self.shared_examples
    @shared_examples ||= {}
  end
end

module MiniTest::Spec::SharedExamples
  def shared_examples_for(desc, &block)
    MiniTest::Spec.shared_examples[desc] = block
  end
 
  def it_behaves_like(desc)
    self.instance_eval do
      MiniTest::Spec.shared_examples[desc].call
    end
  end
end
 
Object.class_eval { include(MiniTest::Spec::SharedExamples) }
