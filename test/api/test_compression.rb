require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')

shared_examples_for 'A Pipeline' do
  describe 'compression' do
    let(:app) { rack_app }
    before do
      assets_location =  "#{fixture_path('asset_pack_app')}/assets/"
      pipeline        = @pipeline
      mock_app do
        register Padrino::Pipeline
        configure_assets do |config|
          config.pipeline = pipeline
          config.css_assets = "#{assets_location}/stylesheets"
          config.js_assets  = "#{assets_location}/javascripts"
        end
      end
    end

    it 'should not compress css in development mode' do
      get '/assets/stylesheets/app.css'
      assert_match "body {\n", last_response.body
    end

    it 'should not compress js in development mode' do
      get '/assets/javascripts/app.js'
      assert_match "function test() {\n", last_response.body
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
