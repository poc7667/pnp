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

RAILS_ROOT = "/home/ar8/pnp"
DROPBOX_DIR = "/home/ar8/Dropbox"


every :reboot do  

  command "cd #{DROPBOX_DIR} ; echo `date` >> \"whenever_reboot.txt\""
  command "cd  #{RAILS_ROOT}"
  command "cd  #{RAILS_ROOT} ; rake sunspot:solr:start"

end 

every 1.minute do
  command "cd #{DROPBOX_DIR} ; python backup_postgres.py "
end

