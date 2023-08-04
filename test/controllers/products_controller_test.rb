require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login
  end
  
  test 'should get index' do
    get products_path

    assert_response :success
    assert_select '.product', 12
    assert_select '.category', 10
  end

  test 'should get index filtered by category' do
    get products_path(category_id: categories(:computers).id)

    assert_response :success
    assert_select '.product', 5
  end

  test 'should get index filtered by price' do
    get products_path(min_price: 200, max_price: 250)

    assert_response :success
    assert_select '.product', 1
    assert_select 'h2', 'Switch Used'
  end

  test 'should get index filtered by text' do
    get products_path(query_text: 'Switch')

    assert_response :success
    assert_select '.product', 1
    assert_select 'h2', 'Switch Used'
  end

  test 'should get index filtered by option Most expensive' do
    get products_path(order_by: 'expensive')

    assert_response :success
    assert_select '.product', 12
    assert_select '.products .product:first-child h2', 'Seat Panda classic'
  end

  test 'should get index filtered by option Cheapest' do
    get products_path(order_by: 'cheapest')

    assert_response :success
    assert_select '.product', 12
    assert_select '.products .product:first-child h2', 'The hobbit'
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
    post products_path, params: { product: { title: 'Xbox', description: 'New Xbox', price: '275', category_id: categories(:videogames).id } }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product was successfully created.'
  end

  test 'should not create product with empty fields' do
    post products_path, params: { product: { title: '', description: 'New Xbox', price: '275' } }

    assert_response :unprocessable_entity
  end

  test 'should get edit' do
    get edit_product_path(products(:PS4))

    assert_response :success
    assert_select 'form'
  end

  test 'should update product' do
    patch product_path(products(:PS4)), params: { product: { price: '265' } }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product was successfully updated.'
  end 

  test 'should not update product' do
    patch product_path(products(:PS4)), params: { product: { price: nil } }

    assert_response :unprocessable_entity
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:PS4))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Product was successfully deleted.', status: :see_other
  end
end
