class TagsController < ApplicationController

  def index
  	@tags = current_user.tags
  	@tag = current_user.tags.new
  end

  def edit
    @tag = current_user.tags.find(params[:id])
  end

  def new
    @tag = current_user.tags.new
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

  def destroy
  	@tag = current_user.tags.find(params[:id]) 
  	@tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
  	end
  end

  private 

  def tag_params
  	params.require(:tag).permit(:name, :id, :user_id)
  end
end
