require File.expand_path(File.dirname(__FILE__) + '/../../helpers/helper')
require File.expand_path(File.dirname(__FILE__) + '/../../fixtures/sprockets_app/sprockets_app')

require 'bootstrap-sass'

describe :sprockets_javascript do
  let(:app) { rack_app }

  before do 
    asset_path   = "#{fixture_path('sprockets_app')}/assets"
    public_path  = "#{fixture_path('sprockets_app')}/public"
    mock_app do
      register Padrino::Pipeline
      register Padrino::Helpers

      configure_assets do |assets|
        assets.pipeline        = Padrino::Pipeline::Sprockets
        assets.js_assets       = [ "#{asset_path}/javascripts", Bootstrap.javascripts_path ]
        assets.css_assets      = [ "#{asset_path}/stylesheets", Bootstrap.stylesheets_path ]
        assets.compiled_output = "#{public_path}"
      end

    end
  end

  context 'javascript' do
    it 'can get a javascript file from the bootstrap gem' do
      get '/assets/javascripts/bootstrap.js'
      assert_match "getbootstrap\.com", last_response.body
    end
  end

  context 'css' do
    it 'finds the example bootstrap gems assets' do
      get '/assets/stylesheets/boot.css'
      assert_match "normalize\.css", last_response.body
    end

    it 'finds the example bootstrap gem with a require directive' do
      get '/assets/stylesheets/require_bootstrap.css'
      assert_match "normalize\.css", last_response.body
    end
  end

end
