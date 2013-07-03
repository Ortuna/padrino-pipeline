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

end
