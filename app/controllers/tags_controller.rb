class TagsController < ApplicationController

  def index
  	@tags = current_user.tags.where({:active => true}).arrange
  	@tag = current_user.tags.new(:parent_id => params[:parent_id])
  end

  def edit
    @tag = current_user.tags.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def new
    @tag = current_user.tags.new(:parent_id => params[:parent_id])
    respond_to do |format|
      format.html {redirect_to new_tags_path }
      format.js 
    end
  end

  def create
  	@tag = current_user.tags.new(tag_params)
  	 respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_path, notice: "Journal added successfully." }
        format.js
      else
        flash[:error] = "There was a problem adding your Journal."
        render action: :new
      end
    end
  end

  def update
    @tag = current_user.tags.find(params[:id])
    if @tag.update_attributes(tag_params)
      respond_to do |format|
        format.html { redirect_to titles_path, notice: "Journal updated successfully." }
        format.js
      end
    else
      flash[:error] = "Your Journal could not be saved."
      render action: :edit
    end
  end

  def destroy
  	@tag = current_user.tags.find(params[:id]) 
  	@tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
      format.js
  	end
  end

  private 

  def tag_params
  	params.require(:tag).permit(:name, :id, :user_id, :parent_id)
  end
end
