ENV['RACK_ENV'] = 'development'

Bundler.require
# Mongoid.load!('./mongoid.yml') # loaded at puma boot

Datadog.configure do |c|
  c.use(:mongo, service_name: 'mongo')
end

class MongoidDoc
  include Mongoid::Document
end


configure { set :server, :puma }

get '/ping' do
  '200 OK'
end

get '/mongo_create_and_save' do
  MongoidDoc.new.save!
  sleep 3
end
