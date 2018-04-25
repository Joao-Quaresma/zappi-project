require 'test_helper'

class FaqCommentsControllerTest < ActionController::TestCase
  setup do
    @faq_comment = faq_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faq_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faq_comment" do
    assert_difference('FaqComment.count') do
      post :create, faq_comment: {  }
    end

    assert_redirected_to faq_comment_path(assigns(:faq_comment))
  end

  test "should show faq_comment" do
    get :show, id: @faq_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @faq_comment
    assert_response :success
  end

  test "should update faq_comment" do
    patch :update, id: @faq_comment, faq_comment: {  }
    assert_redirected_to faq_comment_path(assigns(:faq_comment))
  end

  test "should destroy faq_comment" do
    assert_difference('FaqComment.count', -1) do
      delete :destroy, id: @faq_comment
    end

    assert_redirected_to faq_comments_path
  end
end
