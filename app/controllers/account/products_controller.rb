class Account::ProductsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  def index
    @products = current_user.cart
  end
  def update

  end
  def destroy
    current_user.user_products.destroy_all
    flash[:warning]= "購物車已清空"
    redirect_to account_products_path
  end
end
