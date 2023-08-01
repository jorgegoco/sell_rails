require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @Switch = products(:Switch)
    @megadrive = products(:megadrive)
  end

  test 'should get index' do
    get favorites_url

    assert_response :success
  end

  test 'should create favorite' do
    assert_difference('Favorite.count', 1) do
      post favorites_url(product_id: @Switch.id)
    end
    
    assert_redirected_to product_path(@Switch)
  end

  test 'should delete favorite' do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(@megadrive.id)
    end
    
    assert_redirected_to product_path(@megadrive)
  end
end
