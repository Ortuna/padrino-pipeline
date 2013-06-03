require 'padrino-core'
require 'padrino-assets'

class AssetsApp < Padrino::Application
  register Padrino::Assets
  configure do
    set :logging, false
    set :padrino_logging, false
  end
end

Padrino.load!
