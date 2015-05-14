require "rvm/capistrano"
require "bundler/capistrano"

default_run_options[:pty] = true

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

set :pty, true


server '104.236.57.97', :web, :app, :db, primary: true

set :ssh_options, {
    forward_agent: false,
    auth_methods: %w(password),
    password: 'memree123!@#',
    user: 'deployer',
}
