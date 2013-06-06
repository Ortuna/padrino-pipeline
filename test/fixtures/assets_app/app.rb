require 'padrino-core'
require 'padrino-assets'

class AssetsApp < Padrino::Application
  register Padrino::Assets

  configure do
    set :logging, false
    set :padrino_logging, false
  end

  configure_assets do |assets|
    assets.pipeline   = Padrino::Assets::Sprockets
    assets.paths      = ["#{File.dirname(__FILE__)}/assets/javascripts",
                         "#{File.dirname(__FILE__)}/assets/stylesheets" ]
  end


end

Padrino.load!
