require File.expand_path(File.dirname(__FILE__) + '/helpers/helper')

describe :configuration do
  it 'can find the correct compiler' do
    class SomeApp < Padrino::Application; end
    config = Padrino::Pipeline::Configuration.new(SomeApp)

    config.pipeline = Padrino::Pipeline::Sprockets.new(SomeApp, config)
    assert_equal Padrino::Pipeline::Compiler::Sprockets, config.send(:match_compiler)

    config.pipeline = Padrino::Pipeline::AssetPack.new(SomeApp, config)
    assert_equal Padrino::Pipeline::Compiler::AssetPack, config.send(:match_compiler)

    # config.pipeline = nil
    # assert_equal nil, config.send(:match_compiler)
  end

  describe 'feature resolver' do
    before do
      class ConfigApp < Padrino::Application
        register Padrino::Pipeline
      end
      @test_app = ConfigApp.dup
    end

    it 'requires proper scripts' do
      @test_app.class_eval do
        configure_assets do |config|
          config.pipeline = :sprockets
        end
      end
      assert_equal 'Padrino::Pipeline::Sprockets', @test_app.pipeline.pipeline.class.to_s
    end

    it 'raises error when the pipeline is not found' do
      e = assert_raises(RuntimeError) do
        @test_app.class_eval do
          configure_assets do |config|
            config.pipeline = :shady
          end
        end
      end
      assert_equal 'shady pipeline is not registered', e.message
    end
  end
end
