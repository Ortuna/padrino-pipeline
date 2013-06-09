require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/asset_pack_app/asset_pack_app')

describe 'AssetPack Stylesheets' do
  let(:app) { AssetsAppAssetPack }

  it 'can get a stylesheet file' do
    get '/assets/stylesheets/app.css'
    assert_equal 200, last_response.status
  end

  it 'makes sure that sass is compiled' do
    get '/assets/stylesheets/default.css'
    assert_equal 200, last_response.status
    assert_match ".content {\n  display: none; }\n", last_response.body
  end

  it 'gives 404 for unknown files' do
    get '/assets/stylesheets/omg.css'
    assert_equal 404, last_response.status
  end

  context 'for non-defualt options' do
    let(:app) { AssetsAppAssetPackCustom }

    it 'can serve from another stylesheets path' do
      get '/meow/stylesheets/meow.css'
      assert_equal 200, last_response.status
      assert_match '.meow', last_response.body 
    end

    context 'for non-default css_assets path' do
      let(:app) { rack_app }  
      before do
        @app_root = "#{fixture_path('asset_pack_app')}"
      end

      it '#css_assets can be an array' do
        app_root = @app_root
        mock_app do
          set :root, app_root
          register Padrino::Pipeline
          configure_assets do |assets|
            assets.pipeline = Padrino::Pipeline::AssetPack
            assets.css_assets = ['/some/unkown/path/', 'assets/css', 'a/b/c']
          end
        end
        get '/assets/stylesheets/meow.css'
        assert_equal 200, last_response.status
      end


    end

  end
end
