require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/sprockets_app/sprockets_app')


describe 'Javascripts' do
  let(:app) { AssetsAppSprockets }
  context 'for coffeescript assets' do
    it 'can get a coffeescript' do
      get '/assets/javascripts/coffee.js'
      assert_equal 200, last_response.status
    end

    it 'is compiled' do 
      get '/assets/javascripts/coffee.js'
      assert_match 'a="yes"', last_response.body
    end
  end

  context 'for javascript assets' do
    it 'can retrieve a js asset by file name' do
      get '/assets/javascripts/unrequired.js'
      assert_match 'var unrequired;', last_response.body
    end

    it 'is the right content type' do
      get '/assets/javascripts/unrequired.js'
      assert_match 'application/javascript', last_response.content_type
    end

    it 'shows a 404 for unkown assets' do
      get '/assets/javascripts/xyz.js'
      assert_not_equal 200, last_response.status
    end

    context 'for //= require' do
      it 'picks up require statements' do
        get '/assets/javascripts/app.js'
        assert_match 'var in_second_file;', last_response.body
      end
    end

    context 'for custom options' do
      let(:app) { rack_app }
      before do
      @assets_location =  "#{fixture_path('sprockets_app')}/assets/javascripts"
      end

      it '#append_asset_path' do
        assets_location = @assets_location
        mock_app do
          register Padrino::Pipeline
          configure_assets do |assets| 
            assets.pipeline  = Padrino::Pipeline::Sprockets
            assets.js_assets = assets_location
          end
        end

        get '/assets/javascripts/app.js'
        assert_match 'var in_second_file', last_response.body
      end

      it '#js_prefix mounts assets to the correct spot' do
        assets_location = @assets_location
        mock_app do
          register Padrino::Pipeline
          configure_assets do |assets|
            assets.pipeline  = Padrino::Pipeline::Sprockets
            assets.js_assets = assets_location
            assets.js_prefix = '/custom/location'
          end
        end#mock-app
        get '/custom/location/app.js'
        assert_match 'var in_second_file', last_response.body
        assert_equal 200, last_response.status
      end

    end#context
  end#context
end#describe
