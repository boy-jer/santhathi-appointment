require 'test_helper'

class PmsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:pms)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_pms
    assert_difference('Pms.count') do
      post :create, :pms => { }
    end

    assert_redirected_to pms_path(assigns(:pms))
  end

  def test_should_show_pms
    get :show, :id => pms(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => pms(:one).id
    assert_response :success
  end

  def test_should_update_pms
    put :update, :id => pms(:one).id, :pms => { }
    assert_redirected_to pms_path(assigns(:pms))
  end

  def test_should_destroy_pms
    assert_difference('Pms.count', -1) do
      delete :destroy, :id => pms(:one).id
    end

    assert_redirected_to pms_path
  end
end
