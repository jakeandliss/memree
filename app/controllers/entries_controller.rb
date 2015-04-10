class EntriesController < ApplicationController
  before_action :require_user
  layout "application_index", only: :index

  def index
    @title = Title.find(params[:title_id])
    @user = User.find_by(params[:user_id])
    @entry = Entry.new
    @entries = @title.entries
    @images = Image.all
    @tags = Tag.find_by(params[:title_id])
    @tag = Tag.new
  end

  def new
    @title = Title.find(params[:title_id])
    @entry = @title.entries.new
  end

  def create
    @title = Title.find(params[:title_id])
    @entry = @title.entries.new(entry_params)
    if @entry.save
      entry = @title.entries.first
              if entry.present? && params[:images].present?
                params[:images].each do |img|
                entry.images.create(avatar: img) 
              end
              end
      flash[:success] = "Entry added successfully."
      redirect_to title_entries_path
    else
      flash[:error] = "There was a problem adding your entry."
      render action: :new
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
      flash[:success] = "Entry updated successfully."
      redirect_to title_entries_path
    else
      flash[:error] = "Your entry could not be saved."
      render action: :edit
    end
  end

  def destroy
    @title = Title.find(params[:title_id])
    @entry = @title.entries.find(params[:id])
    @entry.destroy
    flash[:notice] = "Entry has been deleted"
    redirect_to title_entries_path(@title)
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
