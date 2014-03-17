require File.expand_path(File.dirname(__FILE__) + '/../../helpers/helper')
require 'ostruct'
require 'bootstrap-sass'

describe Padrino::Pipeline::Compiler::Sprockets do
  before do
    @asset_path   = "#{fixture_path('sprockets_app')}/assets"
    @public_path  = "#{fixture_path('sprockets_app')}/public"
  end

  after do
    FileUtils.rm_rf @public_path
  end

  it 'creates a directory to put compiled assets' do
    config   = OpenStruct.new(compiled_output: @public_path)
    compiler = Padrino::Pipeline::Compiler::Sprockets.new(config)

    compiler.compile(:js)
    assert_equal true, File.exists?(@public_path)
  end

  it 'raises exception on incorrect compile type' do
    skip
    config   = OpenStruct.new( compiled_output: @public_path)
    compiler = Padrino::Pipeline::Compiler::Sprockets.new(config)

    assert_throws(RuntimeError) {  compiler.compile(:somehting) }
  end

  it 'creates the correct directory for javascripts' do
    config_hash = { compiled_output: @public_path,  js_compiled_output: 'javascripts' }
    config   = OpenStruct.new(config_hash)
    compiler = Padrino::Pipeline::Compiler::Sprockets.new(config).compile(:js)
    assert_equal true, File.exists?("#{@public_path}/javascripts")

    config_hash = { compiled_output: @public_path,  js_compiled_output: 'javascripts-compiled' }
    config   = OpenStruct.new(config_hash)
    compiler = Padrino::Pipeline::Compiler::Sprockets.new(config).compile(:js)
    assert_equal true, File.exists?("#{@public_path}/javascripts-compiled")
  end

  it 'creates the correct directory for stylesheets' do
    config_hash = { compiled_output: @public_path,  css_compiled_output: 'stylesheets' }
    config   = OpenStruct.new(config_hash)
    compiler = Padrino::Pipeline::Compiler::Sprockets.new(config).compile(:css)
    assert_equal true, File.exists?("#{@public_path}/stylesheets")

    config_hash = { compiled_output: @public_path,  css_compiled_output: 'stylesheets-compiled' }
    config   = OpenStruct.new(config_hash)
    compiler = Padrino::Pipeline::Compiler::Sprockets.new(config).compile(:js)
    assert_equal true, File.exists?("#{@public_path}/stylesheets-compiled")
  end  

  describe 'Custom compiler settings' do
    let(:app) { rack_app }
    before do 
      asset_path, public_path = @asset_path, @public_path
      mock_app do
        register Padrino::Pipeline
        register Padrino::Helpers

        configure_assets do |assets|
          assets.pipeline        = Padrino::Pipeline::Sprockets
          assets.js_assets       = "#{asset_path}/javascripts"
          assets.css_assets      = "#{asset_path}/stylesheets"
          assets.compiled_output = "#{public_path}"
        end

        get('/js') { render :erb, "<%= javascript_include_tag 'application.js' %>" }
        get('/css') { render :erb, "<%= stylesheet_link_tag 'application.css' %>" }
      end
    end

    after { FileUtils.rm_rf "#{@public_path}/javascripts" }

    context 'asset_tags' do
      it 'should return javascript with the correct digest' do
        @app.pipeline.compile :js

        digest = @app.assets['application.js'].digest
        get '/js'
        assert_match "/assets/javascripts/application-#{digest}.js", last_response.body
      end

      it 'should return stylesheet with the correct digest' do
        @app.pipeline.compile :css
        digest = @app.assets['application.css'].digest
        get '/css'
        assert_match "/assets/stylesheets/application-#{digest}.css", last_response.body
      end
    end

    context 'javascripts' do
      it 'should compile application.js and application.js.gz' do
        @app.pipeline.compile :js

        digest = @app.assets['application.js'].digest
        assert_equal true, File.exists?("#{@public_path}/javascripts/application-#{digest}.js")
        assert_equal true, File.exists?("#{@public_path}/javascripts/application-#{digest}.js.gz")
      end

      it 'should compile files included in the manifest' do
        @app.pipeline.compile :js

        digest = @app.assets['application.js'].digest
        assert_match_in_file 'function in_second_file()', "#{@public_path}/javascripts/application-#{digest}.js"
        assert_match_in_file 'coffee_method', "#{@public_path}/javascripts/application-#{digest}.js"
      end
    end

    context 'stylesheets' do
      it 'should compile application.css and application.css.gz' do
        @app.pipeline.compile :css

        digest = @app.assets['application.css'].digest
        assert_equal true, File.exists?("#{@public_path}/stylesheets/application-#{digest}.css")
        assert_equal true, File.exists?("#{@public_path}/stylesheets/application-#{digest}.css.gz")
      end

      it 'should compile files included in the manifest' do
        @app.pipeline.compile :css

        digest = @app.assets['application.css'].digest
        assert_match_in_file '.home', "#{@public_path}/stylesheets/application-#{digest}.css"
        assert_match_in_file '.div', "#{@public_path}/stylesheets/application-#{digest}.css"
      end

      it 'finds the example bootstrap gems assets' do
        get '/assets/stylesheets/boot.css'
        assert_match "normalize\.css", last_response.body
      end
    end
  end
end
