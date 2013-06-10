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

    it 'GET a basic JS file' do
      get '/assets/javascripts/app.js'
      assert_equal 200, last_response.status
      assert_match 'var mainApp', last_response.body
    end

    it 'GET a coffee script file' do
      get '/assets/javascripts/coffee.js'
      assert_equal 200, last_response.status
      assert_match 'coffee', last_response.body
    end

    it 'is the right content type' do
      get '/assets/javascripts/app.js'
      assert_match 'application/javascript', last_response.content_type
    end

    it 'gives 404 for unknown JS file' do
      get '/assets/javascripts/doesnotexist.js'
      assert_equal 404, last_response.status
    end
  end


  describe 'custom options' do
    let(:app) { rack_app }
    before do
      @assets_location =  "#{fixture_path('asset_pack_app')}/assets/javascripts"
    end

    it 'get JS asset from a custom location' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets| 
          assets.pipeline  = pipeline
          assets.js_assets = assets_location
        end
      end

      get '/assets/javascripts/app.js'
      assert_equal 200, last_response.status
    end

    it 'get JS asset from custom location(Array)' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline  = pipeline
          assets.js_assets = ['some/unknown/source', assets_location]
          assets.js_prefix = '/custom/location'
        end
      end  
      get '/custom/location/app.js'
      assert_equal 200, last_response.status
    end
  
    it 'get JS asset form custom URI' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline  = pipeline
          assets.js_assets = assets_location
          assets.js_prefix = '/custom/location'
        end
      end#mock-app
      get '/custom/location/app.js'
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


