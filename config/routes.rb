ErpProject::Application.routes.draw do
  root :to => "PublicPages#home"
  
  resources :public_pages, :only => [] do 
    get "home", :on => :collection
  end
end
