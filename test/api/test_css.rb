require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')

shared_examples_for 'A Pipeline' do
  describe 'default options' do
    let(:app) { rack_app }
    before do
      pipeline = @pipeline
      app_root = fixture_path('asset_pack_app')
      mock_app do
        set :root, app_root
        register Padrino::Pipeline
        configure_assets{ |c| c.pipeline = pipeline }
      end
    end

    it 'can get a stylesheet file' do
      get '/assets/stylesheets/app.css'
      assert_equal 200, last_response.status
    end

    it 'makes sure that sass is compiled' do
      get '/assets/stylesheets/default.css'
      assert_equal 200, last_response.status
      assert_match ".content {\n  display: none; }\n", last_response.body
    end

    it 'gives 404 for unknown files' do
      skip if @pipeline == Padrino::Pipeline::AssetPack #http_router issue :(
      get '/assets/stylesheets/omg.css'
      assert_equal 404, last_response.status
    end
  end


  describe 'custom options' do
    let(:app) { rack_app }
    before do
      @assets_location =  "#{fixture_path('asset_pack_app')}/assets/stylesheets"
    end

    it 'get CSS asset from a custom location' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets| 
          assets.pipeline  = pipeline
          assets.css_assets = assets_location
        end
      end

      get '/assets/stylesheets/app.css'
      assert_equal 200, last_response.status
    end

    it 'get CSS asset from custom location(Array)' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline  = pipeline
          assets.css_assets = ['some/unknown/source', assets_location]
          assets.css_prefix = '/custom/location'
        end
      end  
      get '/custom/location/app.css'
      assert_equal 200, last_response.status
    end
  
    it 'get CSS asset form custom URI' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline  = pipeline
          assets.css_assets = assets_location
          assets.css_prefix = '/custom/location'
        end
      end#mock-app
      get '/custom/location/app.css'
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


