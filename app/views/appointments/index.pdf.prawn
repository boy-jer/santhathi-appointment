require "prawn/format"

pdf.font 'Courier'

pdf.text "<b> Appointment List <b>"
pdf.text_options.update(:size => 9, :spacing => 7)

 headers = ["<b>No</b>", "<b>Appointment Date</b>", "<b>Appointment Time</b>", "<b>Doctor Name</b>", "<b>Patient Name</b>",   "<b>Reason</b>", "<b>Status</b>",  "<b>Reg No</b>"]

data = []

@appointments.map{|app| data << [app.id, app.appointment_date, app.appointment_time.strftime('%H:%M'), app.doctor.name, app.patient.patient_name, app.reason.name, app.state, app.patient.reg_no] }
pdf.table data,
            :column_widths => { 0 => 30, 1 => 80, 2 => 266.7, 3 => 120, 4 => 50, 5 => 50, 6 => 91.3, 7 => 60 },
            :align => :center,
            :headers => headers,
            :header_color => '9CBDEB',
            :header_text_color => '0042A0',
            :vertical_padding => 3,
            :border_width => 0.4,
            :border_style => :grid,
            :font_size => 9,
            :border_color => 'BDCFE1',
            :header_border_color => 'ffffff',
            :header_border_width => 1 
