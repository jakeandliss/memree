class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_entry, only: [:show, :edit, :update, :destroy]
  before_filter :check_for_mobile, :only => [:index, :edit, :update, :create, :new]

  def index
    @entry = current_user.entries.new(:title_date => Date.today)
    @tags = current_user.tags(:parent_id => params[:parent_id])
    
    # if parametr "tag" exists retrieve entries with specified tag, otherwise retrieve all tags belonging to current user
    if params[:tag]
      @tag = Tag.find_by(name: params[:tag])
      @entries = Entry.childrens_of(@tag).paginate(:page => params[:page], :per_page => 10)
    else
      @entries = current_user.entries.paginate(:page => params[:page], :per_page => 10)
    end 

    @entries = @entries.search(params[:query], date_filters) 
    
    render layout: "entries"

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
      if @entry.save && @entry.add_tags(params[:entry][:all_tags])
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
    if @entry.update_attributes!(entry_params) && @entry.add_tags(params[:entry][:all_tags])
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
    tags = params[:text] ? current_user.tags.where("name LIKE ?", "%#{params[:text]}%").map(&:name) : current_user.tags.all.map(&:name)
    render json: tags
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
