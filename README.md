#Padrino Pipeline
Padrino Pipeline is a gem for [Padrino](http://www.padrinorb.com).  It provides 
a unified way to use several different asset management systems.

[![Build Status](https://travis-ci.org/Ortuna/padrino-pipeline.png?branch=master)](https://travis-ci.org/Ortuna/padrino-pipeline)
[![Code Climate](https://codeclimate.com/github/Ortuna/padrino-pipeline.png)](https://codeclimate.com/github/Ortuna/padrino-pipeline)
[![Dependency Status](https://gemnasium.com/Ortuna/padrino-pipeline.png)](https://gemnasium.com/Ortuna/padrino-pipeline)


##Supported Pipelines
- [Sprockets](https://github.com/sstephenson/sprockets)
- [sinatra-assetpack](https://github.com/rstacruz/sinatra-assetpack)

##Simple Usage

### Gemfile
Add to your Gemfile:
```ruby
gem 'padrino-pipeline'
```

These examples examples setup a pipeline with defaulted options(see default options):

### Sprockets pipeline
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
    end
  end
end
```

### Sinatra AssetPack pipeline
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::AssetPack
    end
  end
end
```

## Options
Certain options can be configured to change the behavior of the pipelines.
These options should be used within the configure_assets block.

for example:
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::AssetPack
      config.css_prefix = '/xyz'
    end
  end
end
```

The following options can be set

### Pipeline
- #pipeline

### Assets URI(mounting location) String
- #css_prefix
- #js_prefix

### Asset location(path to files) String/Array
- #css_assets
- #js_assets

### Prefix prepend this prefix before all assets
- #prefix

### Default option values
TODO

## Asset pack packages
TODO

## Sprocket directive require/include/require tree
TODO
