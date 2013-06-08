require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/asset_pack_app/asset_pack_app')

describe 'AssetPack Packages' do
  let(:app) { rack_app }

  it 'can serve a non-default asset pack' do
    mock_app do
      register Padrino::Assets
      configure_assets do |config|
        config.pipeline   = Padrino::Assets::AssetPack
        config.packages << [:js, :application, '/assets/javascripts/application.js', ['/assets/javascripts/*.js']]
      end
    end
    get '/assets/javascripts/application.js' 
    assert_equal 200, last_response.status
  end

end
