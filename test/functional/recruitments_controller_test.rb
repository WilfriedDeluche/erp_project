require 'test_helper'

class RecruitmentsControllerTest < ActionController::TestCase
  setup do
    @recruitment = recruitments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recruitments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recruitment" do
    assert_difference('Recruitment.count') do
      post :create, recruitment: @recruitment.attributes
    end

    assert_redirected_to recruitment_path(assigns(:recruitment))
  end

  test "should show recruitment" do
    get :show, id: @recruitment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recruitment.to_param
    assert_response :success
  end

  test "should update recruitment" do
    put :update, id: @recruitment.to_param, recruitment: @recruitment.attributes
    assert_redirected_to recruitment_path(assigns(:recruitment))
  end

  test "should destroy recruitment" do
    assert_difference('Recruitment.count', -1) do
      delete :destroy, id: @recruitment.to_param
    end

    assert_redirected_to recruitments_path
  end
end
