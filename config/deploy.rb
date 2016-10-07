#
# Put here shared configuration shared among all children
#
# Read more about configurations:
# https://github.com/railsware/capistrano-multiconfig/blob/master/README.md

set :ssh_options, { forward_agent: true }

set :deploy_env, proc { fetch(:stage).split(':').last }
set :rails_env, fetch(:deploy_env)
set :migration_role, 'db'
set :conditionally_migrate, false # Defaults to false. If true, it skips migration if files in db/migrate not modified
set :assets_prefix, 'assets' # Defaults to 'assets' this should match config.assets.prefix in your rails config/application.rb


set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
# set :linked_files, %w[ .env config/database.yml config/secrets.yml ]
# set :linked_files, %w[ .env config/secrets.yml] 

#set :linked_dirs, %w[ bin log tmp/pids tmp/cache tmp/sockets vendor/bundle ]
set :linked_dirs, %w[ log ]
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :use_sudo, true # false
set :keep_releases, 5

# ref: https://github.com/capistrano/rvm/
# https://github.com/capistrano/rvm/issues/53
# https://github.com/hyperoslo/capistrano-foreman/blob/master/lib/capistrano/tasks/foreman.rb
set :rvm_type, :user
#set :rvm_map_bins, fetch(:rvm_map_bins, []).push('rvmsudo')
# set :foreman_export_path, '/etc/init'
# set :foreman_export_path, "#{shared_path}/init"
set :foreman_use_sudo, false

namespace :foreman do
  desc "Move Scripts"
  task :move_scripts do
    on roles(:all) do
      foreman_export_path = fetch(:foreman_export_path)
      sudo "mv #{foreman_export_path}/* /etc/init/"
      sudo "rm -r #{foreman_export_path}"
    end
  end
  
  # after :export, 'foreman:move_scripts'
end


