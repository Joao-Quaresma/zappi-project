require 'test_helper'

class FaqnotificationsControllerTest < ActionController::TestCase
  setup do
    @faqnotification = faqnotifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faqnotifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faqnotification" do
    assert_difference('Faqnotification.count') do
      post :create, faqnotification: {  }
    end

    assert_redirected_to faqnotification_path(assigns(:faqnotification))
  end

  test "should show faqnotification" do
    get :show, id: @faqnotification
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @faqnotification
    assert_response :success
  end

  test "should update faqnotification" do
    patch :update, id: @faqnotification, faqnotification: {  }
    assert_redirected_to faqnotification_path(assigns(:faqnotification))
  end

  test "should destroy faqnotification" do
    assert_difference('Faqnotification.count', -1) do
      delete :destroy, id: @faqnotification
    end

    assert_redirected_to faqnotifications_path
  end
end
