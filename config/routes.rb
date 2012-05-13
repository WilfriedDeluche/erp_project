ErpProject::Application.routes.draw do
  
  resources :companies

  devise_for :users
  
  root :to => "PublicPages#school"
  
  resources :public_pages, :only => [] do 
    get "school", :on => :collection
    get "news", :on => :collection
    get "contact", :on => :collection
  end
  
  resources :home, :only => [:index]

  resources :school_users do
    put "reinvite_user", :on => :member
  end
  resources :teachers do
    put "reinvite_user", :on => :member
  end
  resources :students do
    put "reinvite_user", :on => :member
    get "recruiters_list", :on => :member
    get "new_recruiter", :on => :member
    post "create_recruiter", :on => :member
  end
  resources :recruiters do
    put "reinvite_user", :on => :member
  end
  
  resources :companies
end
