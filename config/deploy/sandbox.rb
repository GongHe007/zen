role :app, %w{ali-sandbox1}
role :web, %w{ali-sandbox1}
role :db, %w{ali-sandbox1}

set :stage        ,   :sandbox
set :rails_env    ,   :sandbox
set :branch       ,   :sandbox
set :deploy_to    ,   "/var/www/#{fetch(:application)}/#{fetch(:stage)}"