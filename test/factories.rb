Factory.define :department do |de|
  de.dept_name 'Consultation'
  de.description 'General consultation'
end

Factory.define :reason do |r|
  r.name 'General Consultation'
  r.description 'consultation'
end

Factory.define :mode do |r|
  r.name 'Telephonic'
end

Factory.define :doctor_profile do |dp|
  dp.name 'Test Doctor'
  dp.working_from '9:30:00'
  dp.working_to '18:30:00'
  dp.department_id '1'
  dp.designation 'Dr'
end

Factory.define :doctor do |d|
 d.login 'doctor'
 d.password 'password'
 d.password_confirmation 'password'
 d.email 'doctor@example.com'
 d.state 'Active'
 d.department {|de| de.association(:department)}
 d.doctor_profile {|dp| dp.association(:doctor_profile)}
end

Factory.define :appointment do |a|
  a.appointment_date Date.today
  a.appointment_time  Time.now
  a.state 'new' 
  a.doctor {|d| d.association(:doctor)}
  a.mode {|m| m.association(:mode)}
  a.reason {|r| r.association(:reason)}
end

