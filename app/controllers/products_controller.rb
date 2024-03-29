class ProductsController < ApplicationController
  authorize_resource
  before_action :find_group, :except => [:show,:index,:bargain,:special]
  before_action :authenticate_user!, :except => [:show,:index,:bargain,:special]
  before_action :member_required ,:only => [:new,:create]
  before_action :find_cart, :only=>[:show,:want,:not_like,:bargain,:special]
  def index
    @products =Product.all
  end
  def show
    @product = Product.find(params[:id])
  end
  def new
    @product = @group.products.build
  end
  def create
    @product = @group.products.new(product_params)
    @product.owner = current_user
    if @product.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def edit
    @product = current_user.products.find(params[:id])
  end
  def update
    @product = current_user.products.find(params[:id])
    if @product.update(product_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy
    redirect_to group_path(@group)
  end
  def want
    @product = Product.find(params[:id])
    if !current_user.is_want?(@product,@cart)
      up=current_user.user_products.build
      up.product_id=@product.id
      up.save
    else
      flash[:warning]= "此商品已經在購物車囉！"
    end
    redirect_to :back
  end
  def not_like
    @product = Product.find(params[:id])
    if current_user.is_want?(@product,@cart)
      UserProduct.where(user_id:current_user,order_id:nil,product_id:@product.id).destroy_all
    else
      flash[:warning]= "此商品沒有在購物車哦！"
    end
    redirect_to :back
  end
  def bargain
    @products=Product.where('bargain > 0')
  end
  def special
    @products=Product.where('special is true')
  end
  private
    def product_params
      params.require(:product).permit(:name,:cost,:price,:number,:bargain,:special,:photo,:snippet,:description)
    end
    def find_cart
      @cart=Product.joins(:user_products).where(user_products:{user_id:current_user,order_id:nil})
    end
    def find_group
      @group = Group.find(params[:group_id])
    end
    def member_required
      if !current_user.is_member_of?(@group)
        flash[:warning] = "你不是這個部門的員工喔"
        redirect_to group_path(@group)
      end
    end
end
