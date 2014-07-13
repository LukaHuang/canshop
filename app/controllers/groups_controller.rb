class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end
  def show
    @group = Group.find(params[:id])
    @products = @group.products
    set_page_title @group.title
    set_page_description @group.description
    set_page_keywords @group.title
  end
  def new
    @group = Group.new
  end
  def create
    @group = Group.new(group_params)
    @group.save
    redirect_to group_path(@group)
  end
  def edit 
    @group = Group.find(params[:id])
  end
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
  private
    def group_params
      params.require(:group).permit(:title,:description)
    end
end
