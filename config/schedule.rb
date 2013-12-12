# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

RAILS_ROOT = "/Users/hsu-wei-cheng/Dropbox/Rails/zeus"

every :reboot do  

  command "echo `date` >> \"whenever_reboot.txt\""
  command "cd  #{RAILS_ROOT}"
  command "pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
  command "rake sunspot:solr:start"
  command "redis-server /usr/local/etc/redis.conf" # Check if Ubuntu OK?
  
  # command "rake resque:work QUEUE='*'"
  # command "rake resque_schedule:setup"
  # command "rake resque:scheduler"
  command "resque-web"

  command "god -c #{RAILS_ROOT}/lib/god/resque.god"


end 
