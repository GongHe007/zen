# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "zen"
set :repo_url, "git@github.com:GongHe007/zen.git"
set :user, 'deployer'
set :rvm_ruby_version, '2.3.1@zen'
set :log_level, :info
set :branch, 'master'
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  after :finishing, :cleanup
end

task :restart_sidekiq do
  on roles(:worker) do
    execute :service, "sidekiq restart"
  end
end
after "deploy:published", "restart_sidekiq"