WebsocketRails::EventMap.describe do
  namespace :tasks do
    # using the same syntax as routes.rb
    subscribe :new, 'admin/session#new'
  end
end