class TagsController < ApplicationController

  def index
  	@tags = Tag.all
  	@tag = Tag.new
  end

  def edit
  end

  def new
    @tag = Tag.new
  end

  def create
  	@tag = Tag.new(tag_params)
  	if @tag.save
      flash[:success] = "Journal added successfully."
      redirect_to tags_path
    else
      flash[:error] = "There was a problem adding your Journal."
      render action: :new
    end
  end

  def destroy
  	@tag = Tag.find(params[:id]) 
  	@tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :no_content }
  	end
  end

  private 

  def tag_params
  	params.require(:tag).permit(:name, :id)
  end
end
