class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = current_user.tags.arrange(:order => :name)
  	@tag = current_user.tags.new(:parent_id => params[:parent_id])
  end

  def edit
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
        format.html { redirect_to tags_path, notice: "Label added successfully." }
        format.js
      else
        flash[:error] = "There was a problem adding your label."
        render action: :new
      end
    end
  end

  def update
    if @tag.update_attributes(tag_params)
      respond_to do |format|
        format.html { redirect_to titles_path, notice: "Label updated successfully." }
        format.js
      end
    else
      flash[:error] = "Your label could not be saved."
      render action: :edit
    end
  end

  def destroy
  	@tag = Tag.find(params[:id]) 
  	@tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
      format.js
  	end
  end

  private 

  def fetch_tag
    @tag = current_user.tags.find(params[:id]) 
  end

  def tag_params
  	params.require(:tag).permit(:name, :id, :user_id, :parent_id)
  end

end
