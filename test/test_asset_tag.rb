require File.expand_path(File.dirname(__FILE__) + '/helpers/helper')

shared_examples_for :pipeline do
  describe :asset_tags do

    context 'asset tags for #js #css #image' do
      let(:app) { rack_app }
      before :each do
        assets_location = "#{fixture_path('sprockets_app')}/assets/javascripts"
        public_path     = "#{fixture_path('sprockets_app')}/public"
        pipeline = @pipeline
        mock_app do
          register Padrino::Pipeline
          register Padrino::Helpers
          configure_assets do |assets| 
            assets.pipeline  = pipeline
            assets.js_assets = [assets_location]
          end
          get('/js')    { render :erb, "<%= javascript_include_tag 'app.js' %>" }
          get('/css')   { render :erb, "<%= stylesheet_link_tag 'app.css' %>" }
          get('/image') { render :erb, "<%= image_tag 'image.png' %>" }
        end  
      end

      it 'can use the default javascript_include_tag to resolve JS asset' do
        get '/js'
        assert_match '/assets/javascripts/app.js', last_response.body
      end

      it 'can use the default stylesheet_link_tag to resolve css asset' do
        get '/css'
        assert_match '/assets/stylesheets/app.css', last_response.body
      end

      it 'can use the default image_tag to resolve img asset' do
        get '/image'
        assert_match '/assets/images/image.png', last_response.body
      end

    end
  end
end

describe Padrino::Pipeline::Sprockets do
  before { @pipeline = Padrino::Pipeline::Sprockets }
  it_behaves_like :pipeline
end

describe Padrino::Pipeline::AssetPack do
  before { @pipeline = Padrino::Pipeline::AssetPack}
  it_behaves_like :pipeline
end
