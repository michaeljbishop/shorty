Rails.application.routes.draw do
  get '/', to: redirect('entries/new')

  resources :entries

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/:id', to: 'entries#redirect', as: 'redirect_entry'
end
