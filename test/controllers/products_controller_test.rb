require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get products_path

    assert_response :success
    assert_select '.product', 2 
  end

  test 'should get show' do
    get product_path(products(:PS4))

    assert_response :success
    assert_select '.title', 'PS4 New'
    assert_select '.description', 'New PS4'
    assert_select '.price', '300$'
  end

  test 'should get new' do
    get new_product_path

    assert_response :success
    assert_select 'form' 
  end

  test 'should create product' do
    post products_path, params: { product: { title: 'Xbox', description: 'New Xbox', price: '275' } }

    assert_redirected_to products_path
  end

  test 'should not create product with empty fields' do
    post products_path, params: { product: { title: '', description: 'New Xbox', price: '275' } }

    assert_response :unprocessable_entity
  end
end
