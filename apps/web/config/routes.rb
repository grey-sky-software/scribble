# See: https://guides.hanamirb.org/routing/overview for router docs

root to: 'dashboard#index'

get '/notes', to: 'notes#index', as: :notes_index
post '/notes', to: 'notes#create', as: :notes_create
