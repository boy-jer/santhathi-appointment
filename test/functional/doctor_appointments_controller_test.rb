require 'test_helper'

class DoctorAppointmentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:doctor_appointments)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_doctor_appointment
    assert_difference('DoctorAppointment.count') do
      post :create, :doctor_appointment => { }
    end

    assert_redirected_to doctor_appointment_path(assigns(:doctor_appointment))
  end

  def test_should_show_doctor_appointment
    get :show, :id => doctor_appointments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => doctor_appointments(:one).id
    assert_response :success
  end

  def test_should_update_doctor_appointment
    put :update, :id => doctor_appointments(:one).id, :doctor_appointment => { }
    assert_redirected_to doctor_appointment_path(assigns(:doctor_appointment))
  end

  def test_should_destroy_doctor_appointment
    assert_difference('DoctorAppointment.count', -1) do
      delete :destroy, :id => doctor_appointments(:one).id
    end

    assert_redirected_to doctor_appointments_path
  end
end
