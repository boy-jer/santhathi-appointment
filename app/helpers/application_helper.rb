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

 def appointments(doctor, date = nil)
    #All appointments for the day
   date = date.nil? ? Date.today : date
   app_list = {}
   appointments1 = (doctor.appointments.on_date(date).active)
   appointments1.collect {|appt| app_list[appt.appointment_time.strftime('%H:%M').to_s]= appt}

   return app_list
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
end
