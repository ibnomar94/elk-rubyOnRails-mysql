Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/applications/:token', to: 'applications#show'
  put '/applications/:token', to: 'applications#update'
  get '/applications/:token/chats', to: 'chats#index'
  get '/applications/:token/chats/:chatnumber', to: 'chats#show'
  post '/applications/:token/chats', to: 'chats#create'
  get '/applications/:token/chats/:chatnumber/messages', to: 'messages#index'
  post '/applications/:token/chats/:chatnumber/messages', to: 'messages#create'
  post '/applications/:token/chats/:chatnumber/messages/search', to: 'messages#search'

  resources :applications
  resources :chats
end
