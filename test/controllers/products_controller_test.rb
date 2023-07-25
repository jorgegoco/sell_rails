require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get products_path

    assert_response :success
    assert_select '.product', 2 
  end

  test "should get show" do
    get product_path(products(:PS4))

    assert_response :success
    assert_select '.title', 'PS4 New'
    assert_select '.description', 'New PS4'
    assert_select '.price', '300$'
  end
end
