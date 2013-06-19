require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')

describe 'Asset tags' do

  context 'javascript_include_tag' do
    let(:app) { rack_app }

    it 'can use the default javascript_include_tag to resolve JS asset' do
      assets_location = "#{fixture_path('sprockets_app')}/assets/javascripts"
      mock_app do
        register Padrino::Pipeline
        register Padrino::Helpers
        configure_assets do |assets| 
          assets.pipeline  = Padrino::Pipeline::Sprockets
          assets.js_assets = [assets_location]
        end
        get('/') { render :erb, "<%= javascript_include_tag 'app.js' %>" }
      end

      get '/'
      assert_match '/assets/javascripts/app.js', last_response.body
    end

  end
end

