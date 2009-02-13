require 'test_helper'

class CmsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:cms)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_cms
    assert_difference('Cms.count') do
      post :create, :cms => { }
    end

    assert_redirected_to cms_path(assigns(:cms))
  end

  def test_should_show_cms
    get :show, :id => cms(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => cms(:one).id
    assert_response :success
  end

  def test_should_update_cms
    put :update, :id => cms(:one).id, :cms => { }
    assert_redirected_to cms_path(assigns(:cms))
  end

  def test_should_destroy_cms
    assert_difference('Cms.count', -1) do
      delete :destroy, :id => cms(:one).id
    end

    assert_redirected_to cms_path
  end
end
