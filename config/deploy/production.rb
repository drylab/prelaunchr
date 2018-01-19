role :app,        %w(web02.drylab.io)
role :web,        %w(web02.drylab.io)
role :db,         %w(web02.drylab.io), primary: true
set :application, 'drylab-prelaunchr'

server 'web02.drylab.io', user: fetch(:application), roles: %w(web app db), primary: true

set :full_app_name, 'drylab-prelaunchr'
set :rails_env,   'production'
set :branch,      'master' # select which branch should be deployed
set :deploy_to,   "/home/#{fetch(:full_app_name)}/www/"

set :rvm_ruby_version, '2.3.0@dry-prelaunchr'	# put Ruby version and gemset name here
# set :rvm_type, :system	# uncomment if you need to choose RVM installation manually
# set :rvm_map_bins, %w(rake gem bundle ruby rails)	# uncomment if you need to specify which commands should be prefixed with RVM

namespace :deploy do
  desc 'Restart application'
  task :stop do
    on roles(:app), in: :sequence, wait: 10 do
      execute 'sudo unicornctl stop'
    end
  end

  task :start do
    on roles(:app), in: :sequence, wait: 10 do
      execute 'sudo unicornctl start'
    end
  end

  after :publishing, :stop
  after :stop, :start

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
