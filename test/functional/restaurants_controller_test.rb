require File.dirname(__FILE__) + '/../test_helper'

class RestaurantsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:restaurants)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_restaurant
    assert_difference('Restaurant.count') do
      post :create, :restaurant => { }
    end

    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  def test_should_show_restaurant
    get :show, :id => restaurants(:javaanseetcafe).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => restaurants(:javaanseetcafe).id
    assert_response :success
  end

  def test_should_update_restaurant
    put :update, :id => restaurants(:javaanseetcafe).id, :restaurant => { }
    assert_redirected_to restaurant_path(assigns(:restaurant))
  end

  def test_should_destroy_restaurant
    assert_difference('Restaurant.count', -1) do
      delete :destroy, :id => restaurants(:javaanseetcafe).id
    end

    assert_redirected_to restaurants_path
  end
end
