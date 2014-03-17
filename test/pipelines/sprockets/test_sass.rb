require File.expand_path(File.dirname(__FILE__) + '/../../helpers/helper')
require File.expand_path(File.dirname(__FILE__) + '/../../fixtures/sprockets_app/sprockets_app')


describe :sprockets_javascript do
  let(:app) { AssetsAppSprockets }

  context 'for @import' do
    it 'finds the example bootstrap gems assets' do
      get '/assets/stylesheets/boot.css'
      assert_match "normalize\.css", last_response.body
    end
  end

end
