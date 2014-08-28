class Account::ProductsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  respond_to :json
  def index
    @products = Product.from('user_products AS up').joins('INNER JOIN products AS p ON p.id = up.product_id').where('up.user_id = ? AND up.order_id is ?' ,current_user,nil).select('p.* , up.amount AS amount,up.user_id as user,up.id as up_id')

  end
  def update
    @user_products = UserProduct.find(params[:id])
    
    respond_to do |format|
      @user_products.amount=params[:amount]
      @user_products.save
      format.json { render json:@user_products, status: :ok }
    end
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
