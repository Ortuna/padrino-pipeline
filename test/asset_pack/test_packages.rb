require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/asset_pack_app/asset_pack_app')

describe 'AssetPack Packages' do
  let(:app) { rack_app }

  context 'for javascripts' do
    it 'can serve an asset pack' do
      mock_app do
        register Padrino::Pipeline
        configure_assets do |config|
          config.pipeline   = Padrino::Pipeline::AssetPack
          config.packages << [:js, :application, '/assets/javascripts/application.js', ['/assets/javascripts/*.js']]
        end
      end
      get '/assets/javascripts/application.js' 
      assert_equal 200, last_response.status
    end

    it 'can serve an asset pack from a non-standard location' do
      mock_app do
        register Padrino::Pipeline
        configure_assets do |config|
          config.pipeline   = Padrino::Pipeline::AssetPack
          config.js_prefix  = '/meow/javascripts'
          config.packages << [:js, :application, '/meow/javascripts/application.js', ['/assets/javascripts/*.js']]
        end
      end
      get '/meow/javascripts/application.js' 
      assert_equal 200, last_response.status
    end
  end

  context 'for stylesheets' do
    it 'can serve an asset pack' do
      mock_app do
        register Padrino::Pipeline
        configure_assets do |config|
          config.pipeline   = Padrino::Pipeline::AssetPack
          config.packages << [:css, :application, '/assets/stylesheets/application.css', ['/assets/stylesheets/*.css']]
        end
      end
      get '/assets/stylesheets/application.css' 
      assert_equal 200, last_response.status
    end

    it 'can serve an asset pack from a non-standard location' do
      mock_app do
        register Padrino::Pipeline
        configure_assets do |config|
          config.pipeline   = Padrino::Pipeline::AssetPack
          config.js_prefix  = '/meow/stylesheets'
          config.packages << [:css, :application, '/meow/stylesheets/application.css', ['/assets/stylesheets/*.css']]
        end
      end
      get '/meow/stylesheets/application.css' 
      assert_equal 200, last_response.status
    end
  end

end
