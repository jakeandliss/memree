class EntriesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: :show
  before_action :fetch_entry, only: [:edit, :update, :destroy, :share, :share_with_user, :remove_user,
                                     :share_with_group, :remove_from_group]
  before_filter :check_for_mobile, :only => [:index, :edit, :update, :create, :new]

  def index
    @entry = current_user.entries.build(:title_date => Date.today)
    @tags = current_user.tags(:parent_id => params[:parent_id])
    @contact_form = ContactForm.new
    # if parametr "tag" exists retrieve entries with specified tag, otherwise retrieve all tags belonging to current user
    if params[:tag]
      @tag = current_user.tags.find_by(name: params[:tag])
      @entries = current_user.entries.childrens_of(@tag)
      @shared_entries = params[:tag] == "Shared" ? current_user.shared_entries.active : []
    else
      @entries = current_user.entries
      @shared_entries = current_user.shared_entries.active
    end

    @entries = @entries.search(params[:query], date_filters)
    @all_entries = ((@entries + @shared_entries).sort_by!(&:sortable_date)).reverse!
    @all_entries = @all_entries.paginate(:page => params[:page], :per_page => 10)
    
    respond_to do |format|
      format.html { render layout: "entries" }
      format.js
    end

  end

  def date_filters
      start = params[:start] ? params[:start].to_date : nil
      finish = params[:finish] ? params[:finish].to_date : nil
      return {start: start, finish: finish}
  end

  def new
    @entry = current_user.entries.new(:title_date => Date.today)
    @new_action = true
    render layout: "entries"
  end

  def search
    index
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  def edit
  end

  def create
    @entry = current_user.entries.new(entry_params)

    respond_to do |format|
      if @entry.save && @entry.update_tags_for_user(params[:entry][:all_tags], current_user)
        format.html { redirect_to entries_path, notice: "Entry was created succesfully" }
        format.js
      else
        format.html {
          flash[:error] = "There was a problem adding your entry."
          render action: 'new'
        }
        format.js { render nothing: true}
      end
    end
  end

  def update
    if @entry.update_attributes!(entry_params) && @entry.update_tags_for_user(params[:entry][:all_tags], current_user)
      respond_to do |format|
        format.html { redirect_to entries_path, notice: "Entry was updated succesfully" }
        format.js
      end
    else
      flash[:error] = "Entry has not been updated"
      render action: 'edit'
    end
  end

  def destroy

    if @entry.destroy
      respond_to do |format|
        format.html { redirect_to entries_path, notice: "Entry has been deleted"}
        format.js
      end
    end
  end

  def tag_list
    tags = params[:text] ? current_user.tags.where("lower(name) LIKE ?", "%#{params[:text].downcase}%").map(&:name) : current_user.tags.all.map(&:name)
    render json: tags
  end

  def user_list
    users = params[:text] ? User.where("lower(email) LIKE ? and id <> ?", "%#{params[:text].downcase}%", current_user.id).map(&:email) : User.all.map(&:email)
    render json: users
  end

  def edit_tags
    @entry = Entry.find(params[:id])
    @tags = @entry.tags.where(user_id: current_user.id)
  end

  def update_tags
    @entry = Entry.find(params[:id])
    @tags = @entry.update_tags_for_user(params[:entry][:all_tags], current_user)
  end

  def share
    @entry.add_users(params[:entry][:all_users])
  end

  def hide
    @entry = Entry.find(params[:id])
    @entry_shareable = @entry.entry_shareable.where(user: current_user).first
    @entry_shareable.update(is_hidden: true) if @entry_shareable
  end

  def show
    @user = User.find_by(invitation_token: params[:token])
    if @user
      @entry = @user.shared_entries.find_by(id: params[:id])
      redirect_to(root_path, flash: { error: "Entry not found" }) unless @entry
    else
      redirect_to(root_path, flash: { error: "Invalid Token" })
    end
    puts
  end

  def share_with_user
    user = @entry.add_user(params[:user])
    render json: {success: true, rem_path: remove_user_entry_path(@entry, user_id: user.id),

                  image_path: user.avatar.url(:thumb)}
  end

  def remove_user
    user = User.find_by(id: params[:user_id])
    @entry.shared_users.delete(user) if user
    render json: {success: @entry.shared_users.exclude?(user)}
  end

  def share_with_group
    group = Group.find_by(id: params[:group_id])
    @entry.shared_groups << group if group
    render json: {success: @entry.shared_groups.include?(group)}
  end

  def remove_from_group
    group = Group.find_by(id: params[:group_id])
    @entry.group_shareables.find_by(group_id: group.id).try(:destroy) if group
    render json: {success: @entry.shared_groups.exclude?(group)}
  end

  private

  def fetch_entry
    @entry = current_user.entries.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :content, :title_date, :resource_ids => [])
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

end
