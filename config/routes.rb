Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

patch '/pets/:pet_id/applications/:app_id?status=false', to: 'application_pets#update'
get '/', to: 'welcome#index'
get '/pets', to: 'pets#index'
get '/pets?adoptable=true', to: 'pets#index'
get '/pets?adoptable=false', to: 'pets#index'
get '/pets/:id', to: 'pets#show_pet'
get '/pets/:id/edit', to: 'pets#edit'
patch '/pets/:id', to: 'pets#update'
delete '/pets/:id', to: 'pets#destroy'
get '/shelters', to: 'shelters#index'
get '/shelters?sorted=true', to: 'shelters#index'
get '/shelters?sorted=false', to: 'shelters#index'
get '/shelters?alpha=true', to: 'shelters#index'
get '/shelters?alpha=false', to: 'shelters#index'
get '/shelters/new', to: 'shelters#new'
post '/shelters', to: 'shelters#create'

get '/shelters/:id', to: 'shelters#show'

get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
post '/shelters/:shelter_id', to: 'reviews#create'
patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'

get '/shelters/:shelter_id/pets', to: 'pets#show'
get '/shelters/:shelter_id/pets?adoptable=true', to: 'pets#show'
get '/shelters/:shelter_id/pets?adoptable=false', to: 'pets#show'
get '/shelters/:shelter_id/pets/new', to: 'pets#new'
post '/shelters/:shelter_id/pets', to: 'pets#create'
get '/shelters/:id/edit', to: 'shelters#edit'
patch '/shelters/:id', to: 'shelters#update'
delete '/shelters/:id', to: 'shelters#destroy'
patch '/pets/:id/pending', to: 'pets#change_adoption_status'
patch '/pets/:id/adoptable', to: 'pets#change_adoption_status'

patch '/favorites/:id', to: 'favorites#update'
get '/favorites', to: 'favorites#index'
delete '/favorites/delete_all', to: 'favorites#destroy_all'
delete '/favorites/:id', to: 'favorites#destroy'

patch '/pets/:pet_id/applications/:app_id', to: 'application_pets#update'

get '/applications/new', to: 'applications#new'
get '/applications/:id', to: 'applications#show'
post '/applications', to: 'applications#create'
get '/pets/:id/applications', to: 'applications#pet_apps'





end
