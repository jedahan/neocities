require_relative './environment.rb'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

def create_site
  site_attr = Fabricate.attributes_for :site
  @site = Site.create site_attr
  @user = site_attr[:username]
  @pass = site_attr[:password]
end

describe 'api delete' do
  it 'fails with no or bad auth' do
    post '/api/delete', filenames: ['hi.html']
    res[:error_type].must_equal 'invalid_auth'
    create_site
    basic_authorize 'derp', 'fake'
    post '/api/delete', filenames: ['hi.html']
    res[:error_type].must_equal 'invalid_auth'
  end

  it 'fails with missing filename argument' do
    create_site
    basic_authorize @user, @pass
    post '/api/delete'
    res[:error_type].must_equal 'missing_filenames'
  end

  it 'fails to delete index.html' do
    create_site
    basic_authorize @user, @pass
    post '/api/delete', filenames: ['index.html']
    res[:error_type].must_equal 'cannot_delete_index'
  end

  it 'fails with bad filename' do
    create_site
    basic_authorize @user, @pass
    @site.store_file 't$st.jpg', Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg')
    post '/api/delete', filenames: ['t$st.jpg']
    res[:error_type].must_equal 'bad_filename'

    create_site
    basic_authorize @user, @pass
    post '/api/delete', filenames: ['./config.yml']
    res[:error_type].must_equal 'bad_filename'
  end

  it 'fails with missing files' do
    create_site
    basic_authorize @user, @pass
    @site.store_file 'test.jpg', Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg')
    post '/api/delete', filenames: ['doesntexist.jpg']
    res[:error_type].must_equal 'missing_files'
  end

  it 'succeeds with valid filenames' do
    create_site
    basic_authorize @user, @pass
    @site.store_file 'test.jpg', Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg')
    @site.store_file 'test2.jpg', Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg')
    post '/api/delete', filenames: ['test.jpg', 'test2.jpg']
    res[:result].must_equal 'success'
    site_file_exists?('test.jpg').must_equal false
    site_file_exists?('test2.jpg').must_equal false
  end
end

describe 'api upload' do
  it 'fails with no auth' do
    post '/api/upload'
    res[:result].must_equal 'error'
    res[:error_type].must_equal 'invalid_auth'
  end

  it 'fails for bad auth' do
    basic_authorize 'username', 'password'
    post '/api/upload'
    res[:error_type].must_equal 'invalid_auth'
  end

  it 'fails with missing files' do
    create_site
    basic_authorize @user, @pass
    post '/api/upload'
    res[:error_type].must_equal 'missing_files'
  end

  it 'fails for invalid filenames' do
    create_site
    basic_authorize @user, @pass
    post '/api/upload', {
      '../lol.jpg' => Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg')
    }
    res[:error_type].must_equal 'bad_filename'
  end

  it 'fails for invalid files' do
    create_site
    basic_authorize @user, @pass
    post '/api/upload', {
      'test.jpg' => Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg'),
      'nord.avi' => Rack::Test::UploadedFile.new('./tests/files/flowercrime.wav', 'image/jpeg')
    }
    res[:error_type].must_equal 'invalid_file_type'
    site_file_exists?('test.jpg').must_equal false
    site_file_exists?('nord.avi').must_equal false
  end

  it 'succeeds with single file' do
    create_site
    basic_authorize @user, @pass
    post '/api/upload', 'test.jpg' => Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg')
    res[:result].must_equal 'success'
    site_file_exists?('test.jpg').must_equal true
  end

  it 'succeeds with two files' do
    create_site
    basic_authorize @user, @pass
    post '/api/upload', {
      'test.jpg' => Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg'),
      'test2.jpg' => Rack::Test::UploadedFile.new('./tests/files/test.jpg', 'image/jpeg')
    }
    res[:result].must_equal 'success'
    site_file_exists?('test.jpg').must_equal true
    site_file_exists?('test2.jpg').must_equal true
  end
end

def site_file_exists?(file)
  File.exist?(@site.file_path('test.jpg'))
end

def res
  JSON.parse last_response.body, symbolize_names: true
end

