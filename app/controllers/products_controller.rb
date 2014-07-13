class ProductsController < ApplicationController
  before_action :find_group, :except => [:show,:index]
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
    if @product.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def edit
    @product = @group.products.find(params[:id])
  end
  def update
    @product = @group.products.find(params[:id])
    if @product.update(product_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
  def destroy
    @product = @group.products.find(params[:id])
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
end
