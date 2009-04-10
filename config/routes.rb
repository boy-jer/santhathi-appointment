
# See how all your routes lay out with "rake routes"
ActionController::Routing::Routes.draw do |map|


  map.resources :vital_signs

  map.resources :laboratory_prescription

  map.resources :pharamacy_item_informations

  map.resources :pharmacy_course_lists

  map.resources :pharmacy_dosage_lists

  map.resources :disease_lists

  map.resources :registration_summaries

  map.resources :deactivate_slots

  map.resources :parameters

  map.resources :samples

  map.resources :measurement_units

   map.resources :services, :collection=>{:child_list =>:get}
 # map.resources :roles

  map.resources :user_roles
  map.resources :prescriptions
   map.resources :laboratory_test_results, :collection=>{:details =>:get}
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


  map.resources :appointments, :member => {:confirm => :get},:collection=>{:update_doctors_list =>:get}

  map.resources :patients do |patient|
    patient.resources :patient_appointments, :as => :pappointments
  end

  map.resources :lab_tests ,:has_many =>[:sample_specfications, :parameter_specifications]

  map.resources :departments
  map.resources :doctors
  map.root :controller => 'sessions', :action => 'new'
  map.resource :session
  map.resources :pms
  # Profiles
  map.resources :profiles
  map.resources :doctor_appointments
  map.resources :doctor_patients, :collection => { :discharge => :post,:clinical_screen=>:get }
  map.resources :cms




  # Administration
  map.namespace(:admin) do |admin|
    admin.root :controller => 'admin/dashboard', :action => 'index'
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
    admin.resources :dashboard
    admin.resources :roles

  end


  # Install the default routes as the lowest priority.
  #map.musics  ':section/:subsection/:id', :controller => 'select_options', :action => 'show'
  #map.connect ':section/:subsection/:id', :controller => 'select_options'
  map.resources :select_options #TODO: Need to do it in better way
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
