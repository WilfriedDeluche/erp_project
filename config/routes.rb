ErpProject::Application.routes.draw do
  
  resources :recruiters

  devise_for :users
  
  root :to => "PublicPages#school"
  
  resources :public_pages, :only => [] do 
    get "school", :on => :collection
    get "news", :on => :collection
    get "contact", :on => :collection
  end
  
  resources :home, :only => [:index]
  resources :school_users
  resources :teachers
  resources :students
  resources :recruiters
end
