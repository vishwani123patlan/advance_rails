# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "background-jobs"
set :repo_url, "git@example.com:me/my_repo.git github repo"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is [] These files will not be deleted/reset in every release (other files will!!)
 append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is [] Set to a list of folders that should be shared and persisted over all releases, for e.g. log, tmp/pids, nodemodules, etc. These folders will not be deleted/reset in every release (other folders will!!)
 append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
#Set to a number of previous releases you want to keep in the server after each release, I normally keep this to 3
 set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
