Rails.application.routes.draw do
  resources :firmwares, only: [:new, :create]

  root  'firmwares#new'
end
