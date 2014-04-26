require File.expand_path(File.dirname(__FILE__) + '/helpers/helper')

shared_examples_for :pipeline do
  describe 'default options' do
    let(:app) { rack_app }
    before do
      pipeline = @pipeline
      app_root = fixture_path('sprockets_app')
      base     = Padrino::Application
      base     = Sinatra::Base if @pipeline == Padrino::Pipeline::AssetPack
      mock_app(base) do
        set :root, app_root
        register Padrino::Pipeline
        configure_assets{ |c| c.pipeline = pipeline }
      end

    end

    it 'can get a font' do
      get '/assets/fonts/font.woff' 
      assert_equal 200, last_response.status
    end

    it 'should have the right content type' do
      get '/assets/fonts/font.woff' 
      assert_equal 'application/font-woff', last_response.content_type
    end

    it 'gives 404 for unkown font files' do
      get '/assets/fonts/unkown.woff'
      assert_equal 404, last_response.status
    end
  end

  describe 'custom options' do
    let(:app) { rack_app }
    before do
      @assets_location =  "#{fixture_path('sprockets_app')}/assets/fonts"
    end

    it 'get font asset from a custom location' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets| 
          assets.pipeline     = pipeline
          assets.font_assets = assets_location
        end
      end

      get '/assets/fonts/font.woff'
      assert_equal 200, last_response.status
    end

    it 'get font asset from a custom location(Array)' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets| 
          assets.pipeline     = pipeline
          assets.font_assets = ['some/unkown/place', assets_location]
        end
      end

      get '/assets/fonts/font.woff'
      assert_equal 200, last_response.status
    end

    it 'get font asset form custom URI' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline  = pipeline
          assets.font_assets = assets_location
          assets.font_prefix = '/custom/location'
        end
      end#mock-app
      get '/custom/location/font.woff'
      assert_equal 200, last_response.status
    end

    it 'get font asset form custom prefix' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline  = pipeline
          assets.font_assets = assets_location
          assets.prefix  = '/custom'
        end
      end#mock-app
      get '/custom/assets/fonts/font.woff'
      assert_equal 200, last_response.status
    end
   
  end
end

describe 'Padrino::Pipeline::Sprockets' do
  before { @pipeline = Padrino::Pipeline::Sprockets }
  it_behaves_like :pipeline
end

describe 'Padrino::Pipeline::AssetPack' do
  before { @pipeline = Padrino::Pipeline::AssetPack}
  it_behaves_like :pipeline
end


