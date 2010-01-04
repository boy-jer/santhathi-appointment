module ApplicationHelper
  # Yield the content for a given block. If the block yiels nothing, the optionally specified default text is shown.
  #
  #   yield_or_default(:user_status)
  #
  #   yield_or_default(:sidebar, "Sorry, no sidebar")
  #
  # +target+ specifies the object to yield.
  # +default_message+ specifies the message to show when nothing is yielded. (Default: "")

  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end

  # Create tab.
  #
  # The tab will link to the first options hash in the all_options array,
  # and make it the current tab if the current url is any of the options
  # in the same array.
  #
  # +name+ specifies the name of the tab
  # +all_options+ is an array of hashes, where the first hash of the array is the tab's link and all others will make the tab show up as current.
  #
  # If now options are specified, the tab will point to '#', and will never have the 'active' state.

  def tab_to(name, all_options = nil)
    url = all_options.is_a?(Array) ? all_options[0].merge({:only_path => false}) : "#"
    current_url = url_for(:action => @current_action, :only_path => false)
    html_options = {}

    if all_options.is_a?(Array)
      all_options.each do |o|
        if url_for(o.merge({:only_path => false})) == current_url
          #html_options = {:class => "current"}
          name = "<span class = 'current'> #{name} </span>"
          break
        end
      end
    end
    link_to(name, url, html_options)
  end

  # Return true if the currently logged in user is an admin
  def admin?
    logged_in? && current_user.has_role?(:admin)
  end

  def doctor?
    logged_in? && current_user.has_role?(:doctor)
  end

  # Write a secure email adress
  def secure_mail_to(email)
    mail_to email, nil, :encode => 'javascript'
  end

  def cell(label, value)
    "<tr>
  		<td class='label' nowrap='nowrap'>#{label}</td>
  		<td class='value'>#{value}</td>
  	</tr>"
  end

  def cell_separator
    "<tr>
  		<td colspan='2' class='separator'></td>
  	</tr>"
  end

  def all_doctors
     Doctor.find(:all).collect{|h| [h.doctor_name, h.id]}
  end

  def genders
     return [['Female', 'female'], ['Male', 'male']]
  end

  def value_types
     return [['Select value type', ''], 'Numeric', 'Text', 'Boolean(+, -)', 'Multiple', 'Header', 'Comments']
  end
=begin
 def appointments(doctor, date = nil)
   #All appointments for the day
   date = date.nil? ? Date.today : date
   app_list = {}
   appointments1 = (doctor.appointments.on_date(date).active)
   appointments1.collect {|appt| app_list[appt.appointment_time.strftime('%H:%M').to_s]= appt}

   return app_list
 end
=end

 def working_slots(doctor)
   working_slots = []
   slots = doctor.doctor_working_slots
   slots.map{|sl| working_slots += sl.slots} unless slots.blank?
   return working_slots
 end

 def calculate_age(dob)
   today = Date.today
   year = today.year - dob.year
   if today.month < dob.month || (today.month == dob.month && dob.day >= today.day)
     year = year - 1
   end
   return year
  end

  def submit_button(name)
     '<a class="button" onclick="$(this).up("form").submit(); return false;"> <span> #{name}</span></a>'
  end

  # Accounts related
  def current_accounting_period
    user_default_branch.current_accounting_period.name    
  end
  
  def account_group_type_options_array
    user_default_branch.account_group_types.all.map{|m| [m.name, m.id]}
  end
  
  def account_main_group_options_array
    user_default_branch.account_main_groups.all.map{|m| [m.name, m.id]}
  end  
    
  def account_options_array
    @account_options_array = @account_options_array || user_default_branch.accounts.all.map{|m| [m.name, m.id]}.unshift(['',''])
  end

  def setup_particulars(account_transaction)
    returning(account_transaction) do |at|
      at.account_transaction_items.build([{},{},{},{},{},{},{},{},{},{}]) if at.account_transaction_items.blank?
    end
  end

  def setup_inventory(inventory_transaction)
    returning(inventory_transaction) do |it|
      it.inventory_transaction_items.build([{},{},{},{},{},{},{},{},{},{}]) if it.inventory_transaction_items.blank?
    end
  end

  def filter_credit_transactions_items(transaction_items)
    transaction_items.map{|m| m unless m.category == 'Debit'}.compact    
  end

  def inventory_groups_options_array
    user_default_branch.inventory_groups.all.map{|m| [m.name, m.id]}
  end

  def inventory_unit_of_measurements_options_array
    user_default_branch.inventory_unit_of_measurements.all.map{|m| [m.unit_name, m.id]}
  end
  #################
  def all_contact_groups
   ContactGroup.find(:all).map{|m|[m.name,m.id]}
  end
  
   def all_messages
  SavedMessage.find(:all).map{|m|[m.title,m.id]}
 end

end
