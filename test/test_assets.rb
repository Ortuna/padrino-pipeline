require File.expand_path(File.dirname(__FILE__) + '/extra/helper')
pipelines.each do |target_pipeline|
  target_pipeline_class = target_pipeline.to_s.split('::').last
  describe Padrino::Assets do
    let(:app) { Kernel.const_get "AssetsApp#{target_pipeline_class}" }

    context 'for application behavior' do
      it 'knows that assets should be served' do
        assert_equal app.serve_assets?, true
      end

      it 'detects the root location of the running app' do
        app_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app')
        assert_equal app_path, app.root
      end
    end

    context 'general options' do
      let(:app) { rack_app }
      
      before do
       @assets_location = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/assets/javascripts')
      end

      it 'can set a general prefix for all asset types' do
        assets_location = @assets_location
        mock_app do
          register Padrino::Assets
          configure_assets do |assets|
            assets.pipeline = target_pipeline
            assets.paths    = [assets_location]
            assets.prefix   = '/trunk'
          end
        end

        get '/trunk/assets/javascripts/app.js'
        assert_equal 200, last_response.status
      end
    end

  end#describe
end
