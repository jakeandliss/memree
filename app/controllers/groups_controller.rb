class GroupsController < ApplicationController

  # Filters
  before_action :authenticate_user!
  before_action :fetch_group, only: [:edit, :update, :new_member, :create_member, :remove_member]

  def index
    @groups = current_user.groups
  end

  def new
    @group = current_user.groups.new
    render layout: false
  end

  def create
    @group = current_user.groups.create(group_params)
    render layout: false
  end

  def edit
    render layout: false
  end

  def update
    @group.update(group_params)
  end

  def new_member
    render layout: false
  end

  def create_member
    user = User.find_by(email: params[:email])
    if user && @group.member_ids.exclude?(user.id) && current_user.id != user.id
      @group.members << user
    elsif user.nil?
      user = User.invite!(email: params[:email], first_name: params[:first_name], last_name: params[:last_name]){|u| u.skip_invitation = true }
      @group.members << user
    end
    render layout: false
  end

  def remove_member
    user = User.find_by(id: params[:user_id])
    if user && @group.member_ids.include?(user.id) && current_user != user
      @group.members.delete user
    end
    render layout: false
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end

  def fetch_group
    @group = current_user.groups.find(params[:id])
  end
end