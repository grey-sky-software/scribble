# See: https://guides.hanamirb.org/routing/overview for router docs

root to: 'dashboard#index'

get '/notes', to: 'notes#index', as: :note_list
post '/notes', to: 'notes#create', as: :create_note
