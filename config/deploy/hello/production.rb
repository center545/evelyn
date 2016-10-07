# TODO: configure the remote server name and user info
server "example.com", user: "deployer", roles: %w[ web app db ]

set :branch, 'master' # ask :branch, 'master'
set :linked_files, %w[ .env ] 

set :application, proc { fetch(:stage).split(':').reverse[1] }
# TODO: define the correct git repo url
set :repo_url, proc { "git@github.com:evelyn/hello_world.git" }
#TODO: define the correct user path location below
set :deploy_to, proc { "/home/deployer/#{fetch(:application)}" }
set :foreman_export_path, "/home/deployer/#{fetch(:application)}/shared/init"


after 'deploy:updated', 'deploy:compile_assets'
after 'deploy:updated', 'deploy:normalize_assets'
after 'deploy:reverted', 'deploy:rollback_assets'

after 'deploy:published', 'deploy:migrate'
after 'deploy:finished', 'deploy:log_revision'

#before 'deploy:publishing', 'foreman:export'

after 'deploy:published', 'foreman:export'
after 'deploy:published', 'foreman:restart'

#after 'deploy:published', 'foreman:setup'
