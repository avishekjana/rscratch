Rscratch::Engine.routes.draw do

  resources :exceptions do 
    member do
      post "toggle_ignore"
      post "resolve"
    end
    collection do
      get "log/:id", to: "exceptions#log", as: "log"
    end
  end    

  get "dashboard/index"

  root to: "dashboard#index"
end
