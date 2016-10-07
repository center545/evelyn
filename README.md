=app_deploy

1. Make a folder for each application under 'deploy'
2. Add an environment specific deploy file. Currently only production.rb exists
3. List of commands - cap -T

A. To setup a specific application, run
- cap appname:production deploy:check
- if the check fails, install RVM and Ruby 2.3 along with bundler gem. Recheck until successful
- create any symlink files as necessary (e.g. .env, secrets.yml, database.yml etc under shared folder)
- cap appname:production deploy 

Everything should run without any errors.

------
The 'docs' folder contains some example files for the capistrano shared folder

