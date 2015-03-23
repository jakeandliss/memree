class EntriesController < ApplicationController
  def index
    @title = Title.find(params[:title_id])
  end

  def new
    @title = Title.find(params[:title_id])
    @entry = @title.entries.new
  end

  def create
    @title = Title.find(params[:title_id])
    @entry = @title.entries.new(entry_params)
    if @entry.save
      flash[:success] = "Added todo list item."
      redirect_to title_entries_path
    else
      flash[:error] = "There was a problem adding that todo list item."
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
      flash[:error] = "That Entry could not be saved."
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
    params[:entry].permit(:entry, :id, :title_id, :entry_id)
  end

end
