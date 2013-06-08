require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/asset_pack_app/asset_pack_app')

describe 'AssetPack Packages' do
  let(:app) { rack_app }

  context 'for javascripts' do
    it 'can serve an asset pack' do
      mock_app do
        register Padrino::Assets
        configure_assets do |config|
          config.pipeline   = Padrino::Assets::AssetPack
          config.packages << [:js, :application, '/assets/javascripts/application.js', ['/assets/javascripts/*.js']]
        end
      end
      get '/assets/javascripts/application.js' 
      assert_equal 200, last_response.status
    end

    it 'can serve an asset pack from a non-standard location' do
      mock_app do
        register Padrino::Assets
        configure_assets do |config|
          config.pipeline   = Padrino::Assets::AssetPack
          config.js_prefix  = '/meow/javascripts'
          config.packages << [:js, :application, '/meow/javascripts/application.js', ['/assets/javascripts/*.js']]
        end
      end
      get '/meow/javascripts/application.js' 
      assert_equal 200, last_response.status
    end
  end

  context 'for stylesheets' do


  end
end
