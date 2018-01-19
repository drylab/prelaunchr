role :app,        %w(apps02.binarapps.com)
role :web,        %w(apps02.binarapps.com)
role :db,         %w(apps02.binarapps.com), primary: true
set :application, 'create.drylab.io'

server 'apps02.binarapps.com', user: fetch(:application), roles: %w(web app db), primary: true

set :full_app_name, 'create.drylab.io'
set :rails_env,   'production'
set :branch,      'master'
set :deploy_to,   "/home/#{fetch(:full_app_name)}/www/"
set :linked_files, %w(config/database.yml config/unicorn.rb config/config.json)

set :rvm_ruby_version, '2.3.0@dry-prelaunchr'
set :rvm_map_bins, %w(rake gem bundle ruby rails)

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
