class EntriesController < ApplicationController
  before_action :require_user
  layout "application_index", only: :index

  def index
    @title = Title.find(params[:title_id])
    @user = User.find_by(params[:user_id])
    @entry = Entry.new
    @entries = @title.entries
    @images = Image.all
    @tags = @title.tags
    @tag = Tag.new
  end

  def new
    @title = Title.find(params[:title_id])
    @entry = @title.entries.new
  end

  def create
    @title = Title.find(params[:title_id])
    @entry = @title.entries.new(entry_params)
    respond_to do |format|
      if @entry.save
        entry = @title.entries.first
                if entry.present? && params[:images].present?
                  params[:images].each do |img|
                  entry.images.create(avatar: img) 
                end
              end
        format.html { redirect_to title_entries_path, success: "Entry added successfully." }
        format.js
      else
        flash[:error] = "There was a problem adding your entry."
        render action: :new
        end
    end
  end

  def edit
    @title = Title.find(params[:title_id])
    @entry = @title.entries.find(params[:id])
  end

  def update
    @title = Title.find(params[:title_id])
    @entry = @title.entries.find(params[:id])
    if @entry.update_attributes(entry_params)
      respond_to do |format|
        format.html {flash[:success] = "Entry updated successfully."
      redirect_to title_entries_path}
        format.js
      end
    else
      flash[:error] = "Your entry could not be saved."
      render action: :edit
    end
  end

  def destroy
    @title = Title.find(params[:title_id])
    @entry = @title.entries.find(params[:id])
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to title_entries_path(@title), notice: "Entry has been deleted" }
      format.js
    end
  end

  private
  def entry_params
    params[:entry].permit(:entry, :id, :title_id, :entry_id, :image)
  end

  def find_imageable
    params.reverse_each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
