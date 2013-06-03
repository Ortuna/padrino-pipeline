require File.expand_path(File.dirname(__FILE__) + '/helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/app')

describe 'Padrino::Assets' do
  def app; AssetsApp; end

  context 'for application behavior' do
    it 'knows that assets should be served' do
      assert_equal app.serve_assets?, true
    end
  end

  context 'for javascript assets' do
    it 'can retrieve an asset by file name' do
      get '/assets/javascripts/unrequired.js'
      assert_match 'var unrequired;', last_response.body
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

      it 'picks up coffee scripts correctly' do 
        get '/assets/javascripts/app.js'
        assert_match '(function(){var i;i="yes"}).call(this);', last_response.body
      end
    end

    context 'for custom options' do
      def app; rack_app; end
      assets_location = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/assets/javascripts')
      it '#append_asset_path' do
        mock_app do
          register Padrino::Assets
          configure_assets do |assets|
            assets.append_path assets_location
          end
        end#mock-app

        get '/assets/javascripts/app.js'
        assert_match 'var in_second_file', last_response.body
      end

      it '#js_prefix mounts assets to the correct spot' do
        mock_app do
          register Padrino::Assets
          configure_assets do |assets|
            assets.append_path assets_location
            assets.js_prefix = '/custom/location'
          end
        end#mock-app
        get '/custom/location/app.js'
        assert_match 'var in_second_file', last_response.body
      end

    end#context
  end#context
end#describe
