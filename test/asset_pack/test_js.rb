require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/asset_pack_app/asset_pack_app')

describe 'AssetPack Javascripts' do
  let(:app) { AssetsAppAssetPack }

  it 'can get a javascript file' do
    get '/assets/javascripts/app.js'
    assert_equal 200, last_response.status
    assert_match 'var mainApp = true;', last_response.body
  end

  it 'makes sure that manifest includes other scripts' do
    get '/assets/javascripts/application.js'
    assert_equal 200, last_response.status
    assert_match 'var otherFileVar', last_response.body
  end

  it 'makes sure that coffeescript is compiled' do
    get '/assets/javascripts/coffee.js'
    assert_equal 200, last_response.status
    assert_match 'coffee = true', last_response.body
  end

  it 'gives 404 for unknown files' do
    get '/assets/javascripts/omg.js'
    assert_equal 404, last_response.status
  end

  context 'for non-defualt options' do
    let(:app) { mock_app }
    it 'can serve from another javascript path'
    it 'can serve a non-default asset pack'
  end
end
