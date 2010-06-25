ActionController::Routing::Routes.draw do |map|
  map.resources :messages

  map.resources :user_roles


  # RESTful rewrites

  map.signup   '/signup',   :controller => 'users',    :action => 'new'
  map.register '/register', :controller => 'users',    :action => 'create'
  map.activate '/activate/:activation_code', :controller => 'users',    :action => 'activate'
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy', :conditions => {:method => :delete}
  map.dashboard '/dashboard', :controller => 'dashboard', :action => 'index'
  map.read_more '/read_more', :controller => 'dashboard', :action => 'index'

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





  # Profiles
  map.resources :profiles

  # Administration



   map.namespace(:laboratory) do |laboratory|
     laboratory.root :controller => 'laboratory/prescribed_tests', :action => 'index'
     laboratory.resources :prescriptions

#     laboratory.resources :lab_tests ,:has_many =>[:sample_specfications, :parameter_specifications, :inventory_items_used_for_tests]
     laboratory.resources :prescribed_tests , :has_many => :laboratory_reports
     laboratory.resources :laboratory_test_results, :collection => { :details =>:get }
   end


   map.namespace(:cms) do |cms|
   	 cms.root :controller => 'cms/patients', :action => 'index'
   	 cms.resources :patients #, :collection => { :discharge => :post,:clinical_screen=>:get }
   	 cms.resources :appointments
   	 cms.resources :services , :collection => { :child_list => :get }

         cms.resources :prescriptions
   	  cms.resources :doctors do  |doctor|
   	 	  doctor.resource :refer_doctor
   	 	  doctor.resources :patients ,  :collection => { :discharge => :post , :clinical_screen =>:get }
   	 	  doctor.resources :appointments
 	 	 end


     cms.resources :pharamacy_item_informations,:has_one =>[:pharamacy_item_information_detail]

   	 cms.resources :appointments,:has_one => [:clinical_screen,:discharge_summary,:next_appointment_remark,:clinical_comment] ,
   	                             :has_many => [:pharmacy_prescriptions,:refer_doctors ]
     cms.resources :vital_signs
   	 cms.resources :cms

   	 cms.resources :patient_histories ,:collection => { :prescription => :get ,:reports => :get , :pharmacy_prescription=> :get ,:transfer_history => :get ,:alerts => :get ,:discharge_summary => :get , :clinical_comment=> :get ,:visit_report => :get}
   end



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
    admin.resources :dashboard ,:collection => { :reports => :get ,:masters => :get}
    admin.resources :roles
    admin.resources :messages, :collection => {:render_message_template => :get,:render_contact_list => :get} ,:member => {:status_update => :any }
    admin.resources :saved_messages
    admin.resources :contact_groups
    admin.resources :contact_lists
    admin.namespace(:masters) do |masters|
      masters.resources :departments
      masters.resources :doctors
      masters.resources :select_options
      masters.resources :deactivate_slots ,:collection =>{:time_slot => :get ,:update_doctors_list =>:get }
      masters.resources :registration_summaries
      masters.resources :disease_lists
      masters.resources :pharmacy_course_lists
 	    masters.resources :pharmacy_dosage_lists
 	    masters.resources :parameters
      masters.resources :samples
      masters.resources :measurement_units
      masters.resources :lab_tests ,:has_many =>[:sample_specfications, :parameter_specifications, :inventory_items_used_for_tests]
    end

  end



  map.namespace(:pms) do |pms|
    pms.root :controller => 'pms/appointments', :action => 'index'
    pms.resources :appointments, :member => {:confirm => :get} ,
                                 :collection => {:update_doctors_list =>:get, :patient_search => :get} ,
                                 :has_one => [:visit_report]
    pms.resources :pms
    pms.resources :patients, :collection =>{:associate_spouse=> :post, :associate_couple=>:get, :report => :get}
    pms.resources :patients do |patient|
                               patient.resources :patient_appointments, :as => :pappointments
                            end



    pms.resources :pms_reports, :collection => { :date_wise_reports => :get  ,:department_wise_report => :get ,
                                              	:doctor_wise_report => :get , :update_doctors => :get ,
                                              	:appointment_type_report => :get , :visit_type_report => :get
                                              }
     pms.resources :patient_discharges
     pms.resources :visit_reports ,:collection => { :search => :get }
  end

  map.namespace(:pos) do |pos|
    pos.root :controller => 'pos/payments', :action => 'index'
    pos.resources :appointments do |appointment|
      appointment.resources :payments
    end
    pos.resources :payments, :member => {:recieve_payment => :post, :cancel_payment => :post}
    pos.resources :bills
  end

  map.root :controller => 'dashboard', :action => 'home'
  map.resource :session

  # Install the default routes as the lowest priority.
  #map.musics  ':section/:subsection/:id', :controller => 'select_options', :action => 'show'
  #map.connect ':section/:subsection/:id', :controller => 'select_options'
  #map.resources :select_options #TODO: Need to do it in better way
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end

