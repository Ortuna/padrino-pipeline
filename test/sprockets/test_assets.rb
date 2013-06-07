require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')

describe Padrino::Assets do
  let(:app) { AssetsAppSprockets }

  context 'for application behavior' do
    it 'knows that assets should be served' do
      assert_equal app.serve_assets?, true
    end

    it 'detects the root location of the running app' do
      app_path = fixture_path('sprockets_app')
      assert_equal app_path, app.root
    end
  end

  context 'general options' do
    let(:app) { rack_app }
    
    before do
     @assets_location = "#{fixture_path('sprockets_app')}/assets/javascripts"
    end

    it 'can set a general prefix for all asset types' do
      assets_location = @assets_location
      mock_app do
        register Padrino::Assets
        configure_assets do |assets|
          assets.pipeline = Padrino::Assets::Sprockets
          assets.paths    = [assets_location]
          assets.prefix   = '/trunk'
        end
      end

      get '/trunk/assets/javascripts/app.js'
      assert_equal 200, last_response.status
    end
  end

end#describe
