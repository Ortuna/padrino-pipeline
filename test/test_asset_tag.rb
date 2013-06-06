require File.expand_path(File.dirname(__FILE__) + '/extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/app')

describe 'Asset tags' do

  context 'javascript_include_tag' do
    let(:app) { rack_app }

    it 'can use the default javascript_include_tag to resolve JS asset' do
      skip
      assets_location = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/assets/javascripts')
      mock_app do
        register Padrino::Assets
        register Padrino::Helpers
        configure_assets do |assets| 
          assets.pipeline = Padrino::Assets::Sprockets
          assets.paths    = [assets_location]
        end
        get('/') { render :erb, "<%= javascript_include_tag 'app.js' %>" }
      end

      get '/'
      assert_equal '/assets/javascripts/app.js', last_response.body
    end

  end
end
