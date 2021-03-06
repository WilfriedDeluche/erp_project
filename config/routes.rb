ErpProject::Application.routes.draw do

  devise_for :users
  
  root :to => "PublicPages#school"
  
  resources :public_pages, :only => [] do 
    get "school", :on => :collection
    get "news", :on => :collection
    get "contact", :on => :collection
    post "send_email", :on => :collection
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
    get "new_class", :on => :member
    get "contact", :on => :member
    post "send_mail", :on => :member
    
    resources :recruitments, :only => [:index, :new, :create]
    resources :contracts
    resources :evaluations, :only => [:index, :edit, :update, :destroy]
  end
  resources :recruiters do
    put "reinvite_user", :on => :member
  end
  
  resources :companies
  
  resources :trainings
  
  resources :classes, :controller => "klasses" do
    resources :students, :only => [:show] do
      resources :evaluations, :only => [:index]
    end
    resources :evaluations, :except => [:show]
  end

  resources :subjects
  resources :lessons
  resources :evaluations, :only => [:index]
  
  resources :events do
    put "attend", :on => :member
    put "unattend", :on => :member
    
    resources :attendees, :only => [:destroy]
  end
end
