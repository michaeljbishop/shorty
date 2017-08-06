Rails.application.routes.draw do
  get '/', to: redirect('entries/new')

  resources :entries, only: [:show, :new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/:id', to: 'entries#redirect', as: 'redirect_entry'
end
