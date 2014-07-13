class ProductsController < ApplicationController
  def index
    @products =Product.all
  end
  def show
    @product = Product.find(params[:id])
  end
  def new
    @group = Group.find(params[:group_id])
    @product = @group.products.build
  end
  def create
    @group = Group.find(params[:group_id])
    @product = @group.products.new(product_params)
    if @product.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def edit
    @group = Group.find(params[:group_id])
    @product = @group.products.find(params[:id])
  end
  def update
    @group = Group.find(params[:group_id])
    @product = @group.products.find(params[:id])
    if @product.update(product_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
  private
    def product_params
      params.require(:product).permit(:name,:cost,:price,:number)
    end
  
end
