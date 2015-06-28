class GroupsController < ApplicationController

  # Filters
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def new
    @group = current_user.groups.new
    render layout: false
  end

  def create
    @group = current_user.groups.create(group_params)
  end

  def edit
    @group = current_user.groups.find(params[:id])
    render layout: false
  end

  def update
    @group = current_user.groups.find(params[:id])
    @group.update(group_params)
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end