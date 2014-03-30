require File.expand_path(File.dirname(__FILE__) + '/helpers/helper')

shared_examples_for :pipeline do
  describe 'non-default options' do
    let(:app) { rack_app }
    before do
      @assets_location =  "#{fixture_path('asset_pack_app')}/assets/javascripts"
    end

    it 'knows that assets should be served' do
      pipeline = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets {|c| c.pipeline  = pipeline}
      end
      
      assert_equal true, @app.serve_assets?
    end

    it 'can set a general prefix for all asset types' do
      assets_location = @assets_location
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline  = pipeline
          assets.js_assets = assets_location
          assets.prefix    = '/trunk'
        end
      end

      get '/trunk/assets/javascripts/app.js'
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
