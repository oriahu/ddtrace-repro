### Repro via exit from pry, locally
- bundle exec ruby app-repro-exit-pry.rb

---

### Repro via exit from pry in a docker container
- docker build -t ddtrace-repro .
- docker run --name ddtrace-repro-web --network host \
  --env STATSD_URL=host.docker.internal:8125 \
  --rm -it ddtrace-repro:latest \
  bundle exec ruby app-repro-exit-pry.rb

---

#### Repro via shutdown of container running web app, having run mongo query
- docker build -t ddtrace-repro .
- docker run --name ddtrace-repro-web --network host \
  --env STATSD_URL=host.docker.internal:8125 \
  --rm -it ddtrace-repro:latest \
  bundle exec puma -C config/puma.rb

In a separate container, call the running app:
- docker run --name ddtrace-repro-console --network host --rm -it ddtrace-repro:latest bash
- curl localhost:9393/mongo_create_and_save

Finally, stop the container running the app:
- docker stop ddtrace-repro-web -t 61








