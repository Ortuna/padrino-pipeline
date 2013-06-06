require File.expand_path(File.dirname(__FILE__) + '/extra/helper')
pipelines.each do |target_pipeline|
  target_pipeline_class = target_pipeline.to_s.split('::').last
  describe 'Stylesheets' do
    let(:app) { Kernel.const_get "AssetsApp#{target_pipeline_class}" }
    context 'for css assets' do
      it 'can retrieve an css asset by file name' do
        get '/assets/stylesheets/application.css'
        assert_equal 200, last_response.status
      end

      it 'is the right content type' do
        get '/assets/stylesheets/application.css'
        assert_match 'text/css', last_response.content_type
      end    

      it 'works with directives' do
        get '/assets/stylesheets/application.css'
        assert_match '.home {', last_response.body
      end
   
      context 'for SASS assets' do

        it 'can retrieve a .scss asset by file name' do
          get '/assets/stylesheets/sass.css'
          assert_match 'body .div', last_response.body
        end

      end

      context 'for custom options' do
        let(:app) { rack_app }
        before do
          @assets_location = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/assets/stylesheets')
        end

        it 'can modify the default asset path by configuration' do
          assets_location = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/assets/other')
          mock_app do
            register Padrino::Assets
            configure_assets do |assets|
              assets.pipeline = target_pipeline
              assets.paths    = [assets_location]
            end
          end

          get '/assets/stylesheets/other.css'
          assert_equal 200, last_response.status
        end

        it 'can modify the default css prefix by configuration' do
          assets_location = @assets_location
          mock_app do
            register Padrino::Assets
            configure_assets do |assets|
              assets.pipeline   = target_pipeline
              assets.paths      = [assets_location]
              assets.css_prefix = '/myassets/items'
            end
          end

          get '/myassets/items/application.css'
          assert_equal 200, last_response.status
        end

      end #context
    end #context
  end #describe
end
