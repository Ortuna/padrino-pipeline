require 'padrino-core'
require 'padrino-assets'

class AssetsAppSprockets < Padrino::Application
  register Padrino::Assets

  configure do
    set :logging, false
    set :padrino_logging, false
  end

  configure_assets do |assets|
    assets.pipeline   = Padrino::Assets::AssetPack
  end


end

Padrino.load!
