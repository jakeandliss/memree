require "rvm/capistrano"
require "bundler/capistrano"

default_run_options[:pty] = true

# Define the name of the application
set :rvm_type, :system
set :application, 'memree'
set :user, "deployer"
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



# Set the post-deployment instructions here.
# Once the deployment is complete, Capistrano
# will begin performing them as described.
# To learn more about creating tasks,
# check out:
# http://capistranorb.com/

# namespace: deploy do

#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # Your restart mechanism here, for example:
#       execute :touch, release_path.join('tmp/restart.txt')
#     end
#   end

#   after :publishing, :restart

#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end

# end