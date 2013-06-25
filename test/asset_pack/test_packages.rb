require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/asset_pack_app/asset_pack_app')

describe 'AssetPack Packages' do

  context 'for CustomPackApp' do
    let(:app) { CustomPackagesApp }

    it 'can serve a js asset pack' do
      get '/assets/javascripts/application.js' 
      assert_equal 200, last_response.status
      assert_match 'mainApp', last_response.body
    end

    it 'can serve a css asset pack' do
      get '/assets/stylesheets/application.css' 
      assert_equal 200, last_response.status
      assert_match 'body', last_response.body
    end

  end

end
