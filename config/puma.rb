threads 8,8
port 9393
workers 1

worker_timeout 15
worker_shutdown_timeout 8

preload_app!

before_fork { }

on_worker_boot do
  Mongoid.load!("config/mongoid.yml")
end

