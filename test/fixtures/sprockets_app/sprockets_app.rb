require 'padrino-core'
require 'padrino-pipeline'

class AssetsAppSprockets < Padrino::Application
  register Padrino::Pipeline

  configure do
    set :logging, false
    set :padrino_logging, false
  end

  configure_assets do |assets|
    assets.pipeline   = Padrino::Pipeline::Sprockets
  end


end

Padrino.load!
