class Account::ProductsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  respond_to :json
  def index
    @products = Product.joins(:user_products).where(user_products:{user_id:current_user,order_id:nil})
    @up =current_user.user_products.where(order_id:nil)
  end
  def update
    @user_products = UserProduct.find(params[:id])
    
    respond_to do |format|
      @user_products.amount=params[:amount]
      @user_products.save
      format.json { render json:@user_products, status: :ok }
    end
    #respond_to do |format|
    #  format.json {render json :@user_products}
    #  if @user_products.update(user_products_params)
    #    params[:product_id][''].each do |p|
    #      @post_attachment = @post.post_attachments.create!(:avatar => a, :post_id => @post.id)
    #    end
        #format.html { redirect_to @user_products, notice: 'user_products was successfully updated.' }
        #format.json { render :show, status: :ok, location: @user_products }
    #  else
    #    format.html { render :index }
    #    format.json { render json: @user_products.errors, status: :unprocessable_entity }
    #  end
    #end
    #redirect_to account_products_path
  end
  def destroy
    current_user.user_products.where(user_products:{order_id:nil}).destroy_all
    flash[:warning]= "購物車已清空"
    redirect_to account_products_path
  end
  private
    def up_params
      params.require(:user_products).permit(:amount)
    end
end
