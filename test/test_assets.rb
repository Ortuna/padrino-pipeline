require File.expand_path(File.dirname(__FILE__) + '/helper')
require File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app/app')

describe Padrino::Assets do
  let(:app) { AssetsApp }

  context 'for application behavior' do
    it 'knows that assets should be served' do
      assert_equal app.serve_assets?, true
    end

    it 'detects the root location of the running app' do
      app_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/assets_app')
      assert_equal app_path, app.root
    end

  end

end#describe
