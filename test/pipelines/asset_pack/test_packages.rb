require File.expand_path(File.dirname(__FILE__) + '/../../helpers/helper')
require File.expand_path(File.dirname(__FILE__) + '/../../fixtures/asset_pack_app/asset_pack_app')

describe :asset_pack_packages do
  context :custom_package do
    let(:app) { CustomPackagesAppDev }

    it 'can serve a js asset pack' do
      get '/assets/javascripts/app.js' 
      assert_equal 200, last_response.status
      assert_match 'mainApp', last_response.body
    end

    it 'can serve a css asset pack' do
      get '/assets/stylesheets/app.css'
      assert_equal 200, last_response.status
      assert_match 'body', last_response.body
    end

    it 'can get application.js' do
      get '/assets/javascripts/application.js'
      assert_equal 200, last_response.status
    end

    it 'can get application.css' do
      get '/assets/stylesheets/application.css'
      assert_equal 200, last_response.status
    end

  end
end
