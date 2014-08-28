class OrdersController < ApplicationController
  authorize_resource
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @user= (current_user.has_role?(:admin)) ? User.find(@order.user_id) : current_user
    @products = Product.from('user_products AS up').joins('INNER JOIN products AS p ON p.id = up.product_id').where('up.user_id = ? AND up.order_id = ?' ,@user,@order).select('p.* , up.amount AS amount,up.user_id as user')
  end

  # GET /orders/new
  def new
    @order = current_user.orders.build
    @products = Product.from('user_products AS up').joins('INNER JOIN products AS p ON p.id = up.product_id').where('up.user_id = ? AND up.order_id is ?' ,current_user,nil).select('p.* , up.amount AS amount,up.user_id as user')
  end

  # POST /orders
  # POST /orders.json
  def create
    @products = Product.from('user_products AS up').joins('INNER JOIN products AS p ON p.id = up.product_id').where('up.user_id = ? AND up.order_id is NULL' ,@user).select('p.* , up.amount AS amount,up.user_id as user')
    @products = Product.from('user_products AS up').joins('INNER JOIN products AS p ON p.id = up.product_id').where('up.user_id = ? AND up.order_id is ?' ,current_user,nil).select('p.* , up.amount AS amount,up.user_id as user')

    respond_to do |format|
      if @order.save
        current_user.user_products.where(order_id:nil).find_each do |up|
          up.update(order_id: @order.id)
          up.save
          p=Product.find(up.product_id)
          p.update(number:p.number-up.amount)
          p.save
        end
        format.html { redirect_to @order, notice: '訂單已經成立' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /orders/1/edit
  def edit
    @user= (current_user.has_role?(:admin)) ? User.find(@order.user_id) : current_user
    @products = Product.from('user_products AS up').joins('INNER JOIN products AS p ON p.id = up.product_id').where('up.user_id = ? AND up.order_id = ?' ,@user,@order).select('p.* , up.amount AS amount,up.user_id as user')
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: '訂單修改成功' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    current_user.user_products.where(order_id: @order).find_each do |up|
      p=Product.find(up.product_id)
      p.update(number:p.number+up.amount)
      p.save
    end
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: '訂單已取消' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      if current_user.has_role?(:admin)
        params.require(:order).permit(:address, :pay_type,:get_type,:extra,:status,:pay_status)
      else
        params.require(:order).permit(:address, :pay_type,:get_type,:extra)
      end
    end
end
