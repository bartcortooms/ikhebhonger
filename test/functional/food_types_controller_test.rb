require File.dirname(__FILE__) + '/../test_helper'

class FoodTypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:food_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_food_type
    assert_difference('FoodType.count') do
      post :create, :food_type => { }
    end

    assert_redirected_to food_type_path(assigns(:food_type))
  end

  def test_should_show_food_type
    get :show, :id => food_types(:indonesisch).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => food_types(:indonesisch).id
    assert_response :success
  end

  def test_should_update_food_type
    put :update, :id => food_types(:indonesisch).id, :food_type => { }
    assert_redirected_to food_type_path(assigns(:food_type))
  end

  def test_should_destroy_food_type
    assert_difference('FoodType.count', -1) do
      delete :destroy, :id => food_types(:indonesisch).id
    end

    assert_redirected_to food_types_path
  end
end
