require 'padrino-core'
require 'padrino-pipeline'

class BaseApp < Sinatra::Base
  register Padrino::Pipeline

  configure do
    set :logging, false
    set :padrino_logging, false
    set :root, File.dirname(__FILE__)
  end

end

class AssetsAppAssetPack < BaseApp
  configure_assets do |config|
    config.pipeline   = Padrino::Pipeline::AssetPack
  end
end

class AssetsAppAssetPackCustom < BaseApp
  configure_assets do |config|
    config.pipeline   = Padrino::Pipeline::AssetPack
    config.js_prefix  = '/meow/javascripts'
    config.js_assets  = 'assets/js' 
    
    config.css_prefix  = '/meow/stylesheets'
    config.css_assets  = 'assets/css' 
  end
end

class CustomPackagesApp < BaseApp
  configure_assets do |config|
    config.pipeline   = Padrino::Pipeline::AssetPack
    
    config.packages << [:js, :application, '/assets/javascripts/application.js', ['/assets/javascripts/*.js']]
    config.packages << [:css, :application, '/assets/stylesheets/application.css', ['/assets/stylesheets/*.css']]

  end

end
Padrino.load!
