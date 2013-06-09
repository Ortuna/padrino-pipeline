[![Build Status](https://travis-ci.org/Ortuna/padrino-pipeline.png?branch=master)](https://travis-ci.org/Ortuna/padrino-pipeline)
[![Code Climate](https://codeclimate.com/github/Ortuna/padrino-pipeline.png)](https://codeclimate.com/github/Ortuna/padrino-pipeline)
[![Dependency Status](https://gemnasium.com/Ortuna/padrino-pipeline.png)](https://gemnasium.com/Ortuna/padrino-pipeline)
 
#padrino-pipeline
This is an early version and work in progress for padrino pipeline

#Usage
include in your padrino project
```ruby
gem 'padrino-pipeline'
```

##Basic usage

```ruby
module Ortuna
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
    end
  end
end
```

This should default app/assets/javascripts and app/assets/stylesheets to be served
from http://localhost:3000/assets/javascripts and http://localhost:3000/assets/styleseets

##Usage with options
```ruby
module Ortuna
  class App < Padrino::Application
    register Padrino::Pipeline

    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
      config.js_assets  = ['assets/javascripts']
      config.css_assets = 'assets/stylesheets'
      config.js_prefix = '/custom/location'   # defaults to /assets/javascripts
      config.css_prefix = '/custom/stylesheets'   # defaults to /assets/stylesheets

      config.prefix = '/trunk' #general prefix, /trunk/assets/javascripts/xyz.js
    end
  end
end
```

visit `http://localhost:3000/custom/location/app.js` will map to the file
app/assets/javascripts/app.js

visit `http://localhost:3000/custom/stylesheets/main.css` will map to the file
app/assets/stylesheets/main.css

use sprockets helpers like you would:
```javascript
//= require stuff
function stuff() {

}
```
##sinatra-assetpack pipeline
```ruby
class AssetsAppAssetPackCustom < BaseApp
  configure_assets do |config|
    config.pipeline   = Padrino::Pipeline::AssetPack
    config.js_prefix  = '/meow/javascripts'
    config.js_assets  = '/assets/js' 
    
    config.css_prefix  = '/meow/stylesheets'
    config.css_assets  = '/assets/css'
  end
end
```
Since sinatra-assetpack has a different way of serving 

