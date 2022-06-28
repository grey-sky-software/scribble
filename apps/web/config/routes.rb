# See: https://guides.hanamirb.org/routing/overview for router docs

root to: 'dashboard#index'

get '/notes', to: 'notes#index', as: :notes_index
get '/notes/:id', to: 'notes#show', as: :notes_show
post '/notes', to: 'notes#create', as: :notes_create
patch '/notes/:id', to: 'notes#update', as: :notes_update
