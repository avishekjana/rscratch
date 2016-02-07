Rscratch::Engine.routes.draw do

  resources :exceptions do 
    member do
      post "toggle_ignore/:id", action: :toggle_ignore, as: :toggle_ignore
      post "resolve/:id", action: :resolve, as: :resolve
    end
  end    

  get "dashboard/index"

  root to: "dashboard#index"
end
