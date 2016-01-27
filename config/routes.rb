Rscratch::Engine.routes.draw do

  resources :exceptions

  get "dashboard/index"

  root to: "dashboard#index"
end
