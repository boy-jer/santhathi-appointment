require 'test_helper'

class DoctorsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:doctors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_doctor
    assert_difference('Doctor.count') do
      post :create, :doctor => { }
    end

    assert_redirected_to doctor_path(assigns(:doctor))
  end

  def test_should_show_doctor
    get :show, :id => doctors(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => doctors(:one).id
    assert_response :success
  end

  def test_should_update_doctor
    put :update, :id => doctors(:one).id, :doctor => { }
    assert_redirected_to doctor_path(assigns(:doctor))
  end

  def test_should_destroy_doctor
    assert_difference('Doctor.count', -1) do
      delete :destroy, :id => doctors(:one).id
    end

    assert_redirected_to doctors_path
  end
end
