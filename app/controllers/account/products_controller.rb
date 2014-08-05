class Account::ProductsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  def index
    @products = current_user.cart
  end
  def update

  end
end
