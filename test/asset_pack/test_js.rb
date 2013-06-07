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
    get '/assets/javascripts/application.js'
    File.open('/Users/ssingh/Desktop/untitled.html', 'w') do |f|
      f.write(last_response.body)
    end
    assert_equal 200, last_response.status
    assert_match 'var otherFileVar = true;\n', last_response.body
  end

  it 'makes sure that coffeescript is compiled' do

  end

  it 'gives 404 for unknown files' do
    get '/assets/javascripts/omg.js'
    assert_equal 404, last_response.status
  end

  context 'for non-defualt options' do
    let(:app) { mock_app }
    it 'can serve from another javascript path'
  end
end
