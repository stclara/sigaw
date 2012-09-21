require 'test_helper'

class DateCashesControllerTest < ActionController::TestCase
  setup do
    @date_cash = date_cashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:date_cashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create date_cash" do
    assert_difference('DateCash.count') do
      post :create, date_cash: {  }
    end

    assert_redirected_to date_cash_path(assigns(:date_cash))
  end

  test "should show date_cash" do
    get :show, id: @date_cash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @date_cash
    assert_response :success
  end

  test "should update date_cash" do
    put :update, id: @date_cash, date_cash: {  }
    assert_redirected_to date_cash_path(assigns(:date_cash))
  end

  test "should destroy date_cash" do
    assert_difference('DateCash.count', -1) do
      delete :destroy, id: @date_cash
    end

    assert_redirected_to date_cashes_path
  end
end
