require 'test_helper'

class HistoricalCashesControllerTest < ActionController::TestCase
  setup do
    @historical_cash = historical_cashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historical_cashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historical_cash" do
    assert_difference('HistoricalCash.count') do
      post :create, historical_cash: {  }
    end

    assert_redirected_to historical_cash_path(assigns(:historical_cash))
  end

  test "should show historical_cash" do
    get :show, id: @historical_cash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historical_cash
    assert_response :success
  end

  test "should update historical_cash" do
    put :update, id: @historical_cash, historical_cash: {  }
    assert_redirected_to historical_cash_path(assigns(:historical_cash))
  end

  test "should destroy historical_cash" do
    assert_difference('HistoricalCash.count', -1) do
      delete :destroy, id: @historical_cash
    end

    assert_redirected_to historical_cashes_path
  end
end
