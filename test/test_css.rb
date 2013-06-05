require File.expand_path(File.dirname(__FILE__) + '/extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/app')

describe 'Stylesheets' do
  let(:app) { AssetsApp }
  context 'for css assets' do
    it 'can retrieve an css asset by file name' do
      get '/assets/stylesheets/application.css'
      assert_equal 200, last_response.status
    end

    it 'is the right content type' do
      get '/assets/stylesheets/application.css'
      assert_match 'text/css', last_response.content_type
    end    

    it 'works with directives' do
      get '/assets/stylesheets/application.css'
      assert_match '.home {', last_response.body
    end
 
    context 'for custom options' do
      let(:app) { rack_app }
      before do
        @assets_location = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/assets/stylesheets')
      end

      it 'can modify the default asset path by configuration' do
        assets_location = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/assets/other')
        mock_app do
          register Padrino::Assets
          configure_assets { |assets| assets.append_path assets_location }
        end

        get '/assets/stylesheets/other.css'
        assert_equal 200, last_response.status
      end

      it 'can modify the default css prefix by configuration' do
        assets_location = @assets_location
        mock_app do
          register Padrino::Assets
          configure_assets do |assets|
            assets.append_path assets_location
            assets.css_prefix = '/myassets/items'
          end
        end

        get '/myassets/items/application.css'
        assert_equal 200, last_response.status
      end

    end #context
  end #context
end #describe
