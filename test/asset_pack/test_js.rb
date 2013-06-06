require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/asset_pack_app/asset_pack_app')

describe 'AssetPack Javascripts' do
  let(:app) { AssetsAppAssetPack }

  it 'can get application.js' do
    get '/assets/javascripts/application.js'
    assert_equal 200, last_response.status
    assert_match 'var mainApp = true;', last_response.body
  end

  it 'makes sure that manifest includes other scripts' do
    skip
    get '/assets/javascripts/application.js'
    assert_match 'asdf', last_response.body
  end

  it 'makes sure that coffeescript is compiled' do

  end
end
