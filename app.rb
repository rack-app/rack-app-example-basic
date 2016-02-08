require 'bundler'
require 'json'
Bundler.require
Loader.autoload

class App < Rack::App

  mount SomeAppClass

  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Expose-Headers' => 'X-My-Custom-Header, X-Another-Custom-Header'

  serializer do |object|
    object.to_s
  end

  desc 'some hello endpoint'
  get '/hello' do
    'Hello World!'
  end

  desc 'some restful endpoint'
  get '/users/:user_id' do
    response.status = 201
    params['user_id'] #=> restful parameter :user_id
    say #=> "hello world!"
  end

  desc 'some endpoint that has error and will be rescued'
  get '/make_error' do
    raise(StandardError,'error block rescued')
  end


  def say
    "hello #{params['user_id']}!"
  end

  error StandardError, NoMethodError do |ex|
    {:error=>ex.message}
  end

  root '/hello'

end