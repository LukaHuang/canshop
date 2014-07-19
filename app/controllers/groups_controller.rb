class GroupsController < ApplicationController
  authorize_resource
  before_action :authenticate_user! , :except => [:show,:index]
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
    @group = current_user.groups.build(group_params)
    if @group.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def edit 
    @group = current_user.groups.find(params[:id])
  end
  def update
    @group = current_user.groups.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
  def destroy
    @group = current_user.groups.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end
  private
    def group_params
      params.require(:group).permit(:title,:description)
    end
end
