role :app, %w{ali-sandbox1}
role :web, %w{ali-sandbox1}
role :db, %w{ali-sandbox1}

set :stage        ,   :production
set :rails_env    ,   :production
set :branch       ,   :master
set :deploy_to    ,   "/var/www/#{fetch(:application)}/#{fetch(:stage)}"