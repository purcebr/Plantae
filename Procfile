custom_web: bundle exec puma -e $RACK_ENV -b unix:///tmp/web_server.sock --pidfile /tmp/web_server.pid -d -C config/puma.rb
hard_worker: bundle exec sidekiq -q timeblocker