# config valid for current version and patch releases of Capistrano
lock "~> 3.9.1"

set :application, "zen"
set :repo_url, "git@github.com:GongHe007/zen.git"
set :user, 'deployer'
set :rvm_ruby_version, '2.3.1@zen'
set :log_level, :info
set :branch, 'master'
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

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

# task :restart_checker do
#   on roles(:app) do
#     within current_path do
#       with rails_env: fetch(:rails_env) do
#         execute :rake, "order_checker:check_timeout"
#         execute :rake, "sync_coinmarket:eth"
#         execute :rake, "wallet_listener:eth_balance"
#       end
#     end
#   end
# end
after "deploy:published", "restart_sidekiq"
# after "deploy:published", "restart_checker"