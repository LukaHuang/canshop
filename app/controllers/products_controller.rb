class ProductsController < ApplicationController
  authorize_resource
  before_action :find_group, :except => [:show,:index]
  before_action :authenticate_user!, :except => [:show,:index]
  before_action :member_required ,:only => [:new,:create]
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
  private
    def product_params
      params.require(:product).permit(:name,:cost,:price,:number)
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
