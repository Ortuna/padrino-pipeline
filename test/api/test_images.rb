require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')

shared_examples_for 'A Pipeline' do
  describe 'default options' do
    let(:app) { rack_app }
    before do
      pipeline = @pipeline
      app_root = fixture_path('sprockets_app')
      mock_app do
        set :root, app_root
        register Padrino::Pipeline
        configure_assets{ |c| c.pipeline = pipeline }
      end

    end

    it 'can get an image' do
      get '/assets/images/glass.png' 
      assert_equal 200, last_response.status
    end

    it 'gives 404 for unkown image files' do
      get '/assets/images/unkown.png'
      assert_equal 400, last_response.status
    end
  end
end

describe Padrino::Pipeline::Sprockets do
  before { @pipeline = Padrino::Pipeline::Sprockets }
  it_behaves_like 'A Pipeline'
end

describe Padrino::Pipeline::AssetPack do
  before { @pipeline = Padrino::Pipeline::AssetPack}
  it_behaves_like 'A Pipeline'
end


