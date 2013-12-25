# Padrino Pipeline

Padrino Pipeline is a gem for [Padrino](http://www.padrinorb.com). It provides a unified way to use several different asset management systems.

[![Build Status](https://travis-ci.org/Ortuna/padrino-pipeline.png?branch=master)](https://travis-ci.org/Ortuna/padrino-pipeline)
[![Code Climate](https://codeclimate.com/github/Ortuna/padrino-pipeline.png)](https://codeclimate.com/github/Ortuna/padrino-pipeline)
[![Dependency Status](https://gemnasium.com/Ortuna/padrino-pipeline.png)](https://gemnasium.com/Ortuna/padrino-pipeline)


## Supported Pipelines

- [sprockets](https://github.com/sstephenson/sprockets)
- [sinatra-assetpack](https://github.com/rstacruz/sinatra-assetpack)

## Simple Usage

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


## Pipeline
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

`config.pipeline = Padrino::Pipeline::AssetPack`
`config.pipeline = Padrino::Pipeline::Sprockets`

## Assets URI(mounting location) String

###css_prefix
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
      config.css_prefix = '/my_custom_location'
    end
  end
end
```
`/my_custom_location` will be the location css assets are served
e.g. `/my_custom_location/application.css`

###js_prefix
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
      config.js_prefix = '/js'
    end
  end
end
```
`/js` will be the location css assets are served
e.g. `/js/application.js`

## Asset location(path to files) String/Array
###css_assets
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
      config.css_assets = '/path/to/stylesheets'
    end
  end
end
```
`/path/to/stylesheets` will be served at the css_prefix(default: /assets/stylesheets)

###js_assets
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
      config.js_assets = '/path/to/javascripts'
    end
  end
end
```
`/path/to/javascripts` will be served at the js_prefix(default: /assets/javascripts)

## Prefix prepend this prefix before all assets
###prefix
```ruby
module Example
  class App < Padrino::Application
    register Padrino::Pipeline
    configure_assets do |config|
      config.pipeline = Padrino::Pipeline::Sprockets
      config.prefix = '/public'
    end
  end
end
```
prefixes `/public` to all asset URLs.  Above example will serve assets from:
- `/public/assets/stylesheets/application.css`
  # => `http://localhost:3000/public/assets/stylesheets/application.css`
- `/public/assets/javascripts/application.js`
  # => `http://localhost:3000/public/assets/javascripts/application.js`

## Default option values

TODO

## compile asset rake tasks

Add `require 'padrino-pipeline/tasks'` to your Rakefile.

## Sprocket compiled assets

`javascript_include_tag` &amp; `stylesheet_link_tag` have been patched to include the hex digest of compiled assets.
if the assets do not exist a fresh copy will be served via the normal asset URL.
e.g. `application-12abc456xyz.js` vs `application.js`

## Asset pack packages

```ruby
  module Example
    class App < Padrino::Application
      register Padrino::Pipeline
      configure_assets do |config|
        config.pipeline   = Padrino::Pipeline::AssetPack
        config.packages << [:js, :application, '/assets/javascripts/application.js', ['/assets/javascripts/*.js']]
      end
    end
  end
```

Will serve /assets/javascripts/application.js as a bundle

## Sprocket directive require/include/require tree

TODO
