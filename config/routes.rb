Rscratch::Engine.routes.draw do

  resources :exceptions do 
    member do
      post "toggle_ignore"
      post "resolve"
    end
  end    

  get "dashboard/index"

  root to: "dashboard#index"
end
