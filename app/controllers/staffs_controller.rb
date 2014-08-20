class StaffsController < ApplicationController
  #authorize_resource
  def index

  end

  def product_list
    @products = Product.all
  end
  def order_list
    @orders=Order.all
    @users=User.joins(:orders).order("orders.created_at desc")
  end
end
