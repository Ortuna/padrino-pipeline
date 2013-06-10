require File.expand_path(File.dirname(__FILE__) + '/../extra/helper')
require File.expand_path(File.dirname(__FILE__) + '/../fixtures/sprockets_app/sprockets_app')


describe 'Javascripts' do
  let(:app) { AssetsAppSprockets }
  context 'for javascript assets' do
    it 'can retrieve a js asset by file name' do
      get '/assets/javascripts/unrequired.js'
      assert_match 'var unrequired;', last_response.body
    end

    it 'shows a 404 for unkown assets' do
      get '/assets/javascripts/xyz.js'
      assert_not_equal 200, last_response.status
    end

    context 'for //= require' do
      it 'picks up require statements' do
        get '/assets/javascripts/app.js'
        assert_match 'var in_second_file;', last_response.body
      end
    end

    context 'for custom options' do
    end#context
    
  end#context
end#describe
