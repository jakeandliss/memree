require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano-unicorn'

default_run_options[:pty] = true
#set :pty, true

# Define the name of the application
set :rvm_type, :system
set :application, 'memree'
set :user, "deployer"
set :repository, "."
set :password, 'memree123!@#' #deploy's password
set :use_sudo, false

# Define where can Capistrano access the source repository
# set :repo_url, 'https://github.com/[user name]/[application name].git'
set :scm, :git
set :branch, "master"
set :deploy_via, :copy
set :shallow_clone, 1



# Define where to put your application code
set :application, "memree"
set :rails_env, "production"
set :repository, "."
set :deploy_to, "/home/#{user}/#{application}" #path to your app on the production server 




server '104.236.57.97', :web, :app, :db, primary: true , ssh_options: {
    forward_agent: false,
    auth_methods: %w(password),
    password: 'memree123!@#',
    user: 'deployer',
}


after 'deploy:restart', "figaro:setup"
after 'deploy:restart', "figaro:finalize"

namespace :figaro do
  desc "SCP transfer figaro configuration to the shared folder"
  task :setup do
    transfer :up, "config/application.yml", "#{shared_path}/application.yml", :via => :scp
  end
 
  desc "Symlink application.yml to the release path"
  task :finalize do
    run "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
  end
end


after 'deploy:restart', 'unicorn:reload'    # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'   # app preloaded
after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)
