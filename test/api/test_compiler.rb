require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')

describe :configuration do
  it 'can find the correct compiler' do
    class SomeApp < Padrino::Application

    end
    config = Padrino::Pipeline::Configuration.new(SomeApp)

    config.pipeline = Padrino::Pipeline::Sprockets.new(SomeApp, config)
    assert_equal Padrino::Pipeline::Compiler::Sprockets, config.send(:match_compiler)

    config.pipeline = Padrino::Pipeline::AssetPack.new(SomeApp, config)
    assert_equal Padrino::Pipeline::Compiler::AssetPack, config.send(:match_compiler)

    config.pipeline = nil
    assert_equal NilClass, config.send(:match_compiler)
  end

end



# shared_examples_for :pipeline_compiler do
#   describe 'JS compiler' do
#     let(:app) { rack_app }
#     before do
#       assets_location  = "#{fixture_path(@application_name)}/assets/"
#       output_location  = "#{fixture_path(@application_name)}/public/"
#       pipeline         = @pipeline

#       mock_app do
#         register Padrino::Pipeline
#         configure_assets do |config|
#           config.pipeline   = pipeline
#           config.css_assets = "#{assets_location}/stylesheets"
#           config.js_assets  = "#{assets_location}/javascripts"
#         end
#       end
#     end

#     after { FileUtils.rm_rf "#{fixture_path(@application_name)}/public/" }

#     it 'creates the default directory' do
#       skip
#       @app.pipeline.pipeline.compile(:js)
#       output_location  = "#{fixture_path(@application_name)}/public/"
#       assert_equal true, File.exists?(output_location)
#       # FileUtils.mkdir_p output_location unless 
#     end

#     it 'compiles javascript to the default location' do
#       skip
#       #This is unfortunate!
#       @app.pipeline.pipeline.compile(:js)
#       output_location  = "#{fixture_path(@application_name)}/public/"
#     end
#   end
# end

# describe Padrino::Pipeline::Sprockets do
#   before do
#     @pipeline           = Padrino::Pipeline::Sprockets
#     @application_name   = 'sprockets_app'
#   end
#   it_behaves_like :pipeline_compiler
# end

# describe Padrino::Pipeline::AssetPack do
#   before do 
#     @pipeline           = Padrino::Pipeline::AssetPack
#     @application_name   = 'asset_pack_app'
#   end
#   it_behaves_like :pipeline_compiler
# end
