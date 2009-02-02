# See how all your routes lay out with "rake routes"
ActionController::Routing::Routes.draw do |map|
  map.resources :doctor_appointments

  map.resources :cms

  
  # RESTful rewrites
  
  map.signup   '/signup',   :controller => 'users',    :action => 'new'
  map.register '/register', :controller => 'users',    :action => 'create'
  map.activate '/activate/:activation_code', :controller => 'users',    :action => 'activate'
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy', :conditions => {:method => :delete}
  map.dashboard '/dashboard', :controller => 'dashboard', :action => 'index'

  map.user_troubleshooting '/users/troubleshooting', :controller => 'users', :action => 'troubleshooting'
  map.user_forgot_password '/users/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.user_reset_password  '/users/reset_password/:password_reset_code', :controller => 'users', :action => 'reset_password'
  map.user_forgot_login    '/users/forgot_login',    :controller => 'users', :action => 'forgot_login'
  map.user_clueless        '/users/clueless',        :controller => 'users', :action => 'clueless'  
    
  map.resources :users, :member => { :edit_password => :get,
                                     :update_password => :put,
                                     :edit_email => :get,
                                     :update_email => :put,
                                     :edit_avatar => :get, 
                                     :update_avatar => :put }
  
  map.resources :appointments, :member => {:confirm => :post} 
  map.resources :patients
  map.resources :departments 
  map.resources :doctors
  map.root :controller => 'sessions', :action => 'new'                          
  map.resource :session
  map.resources :pms
  # Profiles
  map.resources :profiles
  
  # Administration
  map.namespace(:admin) do |admin|
    admin.root :controller => 'sessions', :action => 'new'
    admin.resources :settings
    admin.resources :users, :member => { :suspend   => :put,
                                         :unsuspend => :put,
                                         :activate  => :put, 
                                         :purge     => :delete,
                                         :reset_password => :put },
                            :collection => { :pending   => :get,
                                             :active    => :get, 
                                             :suspended => :get, 
                                             :deleted   => :get }
 
   
  end
 
 
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
