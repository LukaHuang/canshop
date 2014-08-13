class Account::ProductsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  def index
    @products = current_user.cart
  end
  def update

  end
  def destroy
    #UserProduct.destroy_all(:user_id => current_user)
    current_user.cart.find_each do |up|
      up.destroy
    end

    flash[:warning]= "購物車已清空"
    redirect_to account_products_path
  end
end
