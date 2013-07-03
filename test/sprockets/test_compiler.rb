require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require 'ostruct'

describe 'Padrino::Pipeline::Compiler::Sprockets' do
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

  describe 'Custom compiler settings' do
    let(:app) { rack_app }
    before do 
      asset_path, public_path = @asset_path, @public_path
      mock_app do
        register Padrino::Pipeline
        configure_assets do |assets|
          assets.pipeline        = Padrino::Pipeline::Sprockets
          assets.js_assets       = "#{asset_path}/javascripts"
          assets.css_assets       = "#{asset_path}/stylesheets"
          assets.compiled_output = "#{public_path}"
        end
      end
    end

    after do 
      FileUtils.rm_rf "#{@public_path}/javascripts"
    end
    describe 'javascripts' do
      it 'should compile application.min.js and application.min.js.gz' do
        @app.pipeline.compile :js

        assert_equal true, File.exists?("#{@public_path}/javascripts/application.min.js")
        assert_equal true, File.exists?("#{@public_path}/javascripts/application.min.js.gz")
        
      end

      it 'should compile files included in the manifest' do
        @app.pipeline.compile :js
        assert_match_in_file 'function in_second_file()', "#{@public_path}/javascripts/application.min.js"
        assert_match_in_file 'coffee_method', "#{@public_path}/javascripts/application.min.js"
      end
    end

    describe 'stylesheets' do
      it 'should compile application.min.css and application.min.css.gz' do
        @app.pipeline.compile :css

        assert_equal true, File.exists?("#{@public_path}/stylesheets/application.min.css")
        assert_equal true, File.exists?("#{@public_path}/stylesheets/application.min.css.gz")
        
      end

      it 'should compile files included in the manifest' do
        @app.pipeline.compile :css

        assert_match_in_file '.home', "#{@public_path}/stylesheets/application.min.css"
        assert_match_in_file '.div', "#{@public_path}/stylesheets/application.min.css"
      end
    end
  end
end
