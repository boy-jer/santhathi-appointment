require "prawn/format"

pdf.font 'Courier'

pdf.text "<b> Appointment List <b>"
pdf.text_options.update(:size => 9, :spacing => 10)

 headers = ["<b>No</b>", "<b>Appointment Date</b>", "<b>App Time</b>", "<b>Doctor Name</b>", "<b>Patient Name</b>",   "<b>Reason</b>", "<b>Status</b>",  "<b>Reg No</b>"]

data = []

@appointments.map{|app| data << [app.id, app.appointment_date, app.appointment_time.strftime('%H:%M'), app.doctor.name, app.patient.patient_name, app.reason.name, 'ddd', app.patient.reg_no] }
pdf.table data,
            :column_widths => { 0 => 60, 1 => 65, 2 => 50, 3 => 90, 4 => 90, 5 => 70, 6 => 70, 7 => 70 },
            :align => :center,
            :headers => headers,
            :header_color => '9CBDEB',
            :header_text_color => '0042A0',
            :vertical_padding => 5,
            :border_width => 0.4,
            :border_style => :grid,
            :font_size => 9,
            :border_color => 'BDCFE1',
            :header_border_color => 'ffffff',
            :header_border_width => 1 
