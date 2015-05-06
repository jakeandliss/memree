class TitlesController < ApplicationController
  before_action :authenticate_user!
  layout "application_index", only: :index

  def index
    @title = current_user.titles.new(:title_date => Date.today)
    @tags = current_user.tags(:parent_id => params[:parent_id])
    @images = Image.all

    # if parametr "tag" exists retriece titles with specified tag, otherwise retrieve all tags belonging to current user
    if params[:tag]
      @tag = Tag.find_by(name: params[:tag])
      @titles = Title.childrens_of(@tag).paginate(:page => params[:page], :per_page => 10)
    else
      @titles = current_user.titles.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def search
    index
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  def edit
    @title = current_user.titles.find(params[:id])
  end

  def create
    @title = current_user.titles.new(title_params)
    
    respond_to do |format|
      if @title.save && @title.add_tags(params[:title][:all_tags])
        format.html { redirect_to titles_path, notice: "Entry was created succesfully" }
        format.js
      else
        format.js{ render nothing: true}
        format.html{
          flash[:error] = "There was a problem adding your entry."
          render action: 'new'
        }
      end
    end
  end

  def update
    @title = current_user.titles.find(params[:id])
    if @title.update_attributes!(title_params) && @title.add_tags(params[:title][:all_tags])
      respond_to do |format|
        format.html { redirect_to titles_path, notice: "Entry was updated succesfully" }
        format.js
      end
    else
      flash[:error] = "Entry has not been updated"
      render action: 'edit'
    end

  end

  def destroy
    @title = current_user.titles.find(params[:id])
    @title.destroy
    respond_to do |format|
      format.html { redirect_to titles_path, notice: "Entry has been deleted"
      }
      format.js
    end
  end

  def tag_list
    tags = if params[:text].present?
             current_user.tags.where("name LIKE ?", "%#{params[:text]}%").map(&:name)
           else
             current_user.tags.all.map(&:name)
           end
    render json: tags
  end

  private
  def title_params
    params.require(:title).permit(:title, :entry, :title_date, :image_ids => [])
  end
end
