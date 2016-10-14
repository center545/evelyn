server 'mobizard.com', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:pracdev/testing-deploy.git'
set :application,     'testing-deploy'
# set :user,            'deployer'
set :deploy_to,       "/home2/#{fetch(:user)}/apps/#{fetch(:application)}"
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :branch, 'master' # ask :branch, 'master'
set :foreman_export_path, "/home2/deployer/#{fetch(:application)}/shared/init"

# after 'deploy:updated', 'deploy:compile_assets'
# after 'deploy:updated', 'deploy:normalize_assets'
# after 'deploy:reverted', 'deploy:rollback_assets'

# after 'deploy:published', 'deploy:migrate'
# after 'deploy:finished', 'deploy:log_revision'

#before 'deploy:publishing', 'foreman:export'

after 'deploy:published', 'foreman:export'
after 'deploy:published', 'foreman:restart'

#after 'deploy:published', 'foreman:setup'
