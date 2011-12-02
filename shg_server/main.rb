#! /usr/bin/ruby                                                                                           
dir = File.expand_path(File.dirname(__FILE__))
require "#{dir}/user"
require "#{dir}/log"

# test command: 
# SSH_ORIGINAL_COMMAND="git-upload-pack 'buddylindsey/sourcehold-rails.git'" ruby main.rb "buddylindsey"
# SSH_ORIGINAL_COMMAND="git-receive-pack 'buddylindsey/sourcehold-rails.git'" ruby main.rb "buddylindsey"

# Used to disconnect someone without doing anything
# also prints out an error message
def kick_out(message)
  $stderr.puts message
  exit
end                       

# Does the final universal steps to execute git commands
def finish_up
  exec(ENV['SSH_ORIGINAL_COMMAND'])                                                                  
  #kick_out "SUCCESS: everything worked look at this as the exec command"
end

def backup_queue(message)
  require 'aws-sdk'
  sqs_queue_url = ""
  sqs = AWS::SQS.new(:access_key_id => "", :secret_access_key => "")
  queue = sqs.queues[sqs_queue_url]
  queue.send_message(message) 
end

# makes sure someone isnt just initiating an ssh connection
if(ENV['SSH_ORIGINAL_COMMAND'].nil?)
  kick_out "Sorry this is not an ssh server"
end

username = ARGV[0]      

git_command = ENV['SSH_ORIGINAL_COMMAND'].split(' ')

# checks to make sure the command is allowed                                                               
# git-receive-pack and git-upload-pack are commands                                                        
# git sends to the server when doing pushes and pulls                                                      
if(git_command[0].eql?('git-receive-pack') || git_command[0].eql?('git-upload-pack'))                      
  user = User.new(username)
  
  # user_repo[0] is the username
  # user_repo[1] is the repository
  user_repo = git_command[1].gsub("'", "").split("/")
  if(user_repo.size != 2)
    ActionLog.new.log_action(user.id, 'shg-error-01')
    kick_out "Something went wrong please try again."
  end

  if(git_command[0].eql?('git-receive-pack'))
    backup_queue("#{user_repo[0]}/#{user_repo[1]}")
    ActionLog.new.log_action(user.id, 'commit')
  end

  if(user_repo[0] == username)
    finish_up
  end

  if(user.allowed_to_access_repo?(user_repo[1].chomp(".git")))
    finish_up	
  else
    kick_out "You don't have permission to access this repository."
  end
else                                                                                     
  ActionLog.new.log_action(0, 'shg-error-02')
  kick_out "This is not an SSH server you have been disconnected"
end

ActionLog.new.log_action(0, 'shg-error-03')
$stderr.puts "This is a bad error to get please email Name at (person@example.com) about it"
exit
