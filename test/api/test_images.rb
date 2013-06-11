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
      assert_equal 404, last_response.status
    end
  end

  describe 'custom options' do
    let(:app) { rack_app }
    before do
      @assets_location =  "#{fixture_path('sprockets_app')}/assets/images"
    end

    it 'get image asset from a custom location' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets| 
          assets.pipeline   = pipeline
          assets.image_assets = assets_location
        end
      end

      get '/assets/images/glass.png'
      assert_equal 200, last_response.status
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


