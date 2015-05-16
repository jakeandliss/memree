listen "127.0.0.1:8080"
worker_processes 4
user "deployer"
working_directory "/home/deployer/memree/current"
pid "/home/unicorn/pids/unicorn.pid"
stderr_path "/home/unicorn/log/unicorn.log"
stdout_path "/home/unicorn/log/unicorn.log"

# ------------------------------------------------------------------------------
# Sample rails 3 config
# ------------------------------------------------------------------------------

# Set your full path to application.
app_path = "/home/deployer/memree/current"


# Should be 'production' by default, otherwise use other env 
rails_env = ENV['RAILS_ENV'] || 'production'


# Set master PID location
pid "#{app_path}/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

