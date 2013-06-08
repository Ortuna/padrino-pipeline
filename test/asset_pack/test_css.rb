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

  end
end
