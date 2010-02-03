require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  context "an appointment" do
    setup do
      @appointment = Factory.build(:appointment, :hour => '10', :minute => '20')
    end

    subject { @appointment }

    should_belong_to :doctor
    should_belong_to :patient
    should_belong_to :reason
    should_belong_to :mode
    should_have_one :prescription
    should_have_one :discharge_summary
    should_have_one :next_appointment_remark
    should_have_one :clinical_comment
    should_have_many :pharmacy_prescriptions
    should_have_many :refer_doctors

    should "set appointment time based on hour and minute passed" do
      @appointment.save!
      assert_equal Time.parse('10:20'), @appointment.appointment_time
    end
    
    
      

    
  end
end
