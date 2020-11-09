ENV['RACK_ENV'] = 'development'

Bundler.require
Mongoid.load!('config/mongoid.yml')

Datadog.configure do |c|
  c.use(:mongo, service_name: 'mongo')
end

class MongoidDoc
  include Mongoid::Document
end

# Any mongoid query
MongoidDoc.new.save!

# Sleep is neccesary to see segmentation fault output.
# Otherwise, different error: "~/.rubies/ruby-2.6.5/lib/ruby/2.6.0/timeout.rb:97: [BUG] sleeper must not be more than vm_living_thread_num(vm)"
sleep(6)

# If SystemExit is not raised, script finishes without error
exit
