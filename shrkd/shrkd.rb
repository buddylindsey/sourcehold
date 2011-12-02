require 'daemons'

dir = File.expand_path(File.dirname(__FILE__))

options = {
  :app_name => "shrkd",
  :dir_mode => :normal,
  :dir => dir,
  :multiple => false,
  :ontop => false,
  :backtrace => true,
  :monitor => false,
  :log_dir => dir,
  :log_output => true
}

Daemons.run(File.join(File.dirname(__FILE__), 'server.rb'), options)
