class GroupsController < ApplicationController

  # Filters
  before_action :authenticate_user!
  before_action :fetch_group, only: [:edit]
  # before_filter :check_for_mobile, :only => [:index, :edit, :update, :create, :new]

  def index
    @groups = current_user.groups
  end

end
