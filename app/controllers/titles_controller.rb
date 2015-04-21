class TitlesController < ApplicationController
	before_action :authenticate_user!
	layout "application_index", only: :index
	
	def index
		@title = current_user.titles.new(:title_date => Date.today)
		@title.entries.build
		@tags = current_user.tags
   		@entries = @title.entries
    	@images = Image.all
		if params[:tag]
			@titles = current_user.titles.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 2)
		else
			@titles = current_user.titles.paginate(:page => params[:page], :per_page => 2)
		end
	end

	def edit
		@title = current_user.titles.find(params[:id])
	end

	def create
		@title = current_user.titles.new(title_params)
			respond_to do |format|
				if @title.save
			      
	      				format.html { redirect_to titles_path, notice: "Entry was created succesfully" }
	      				format.js
				else 
					flash[:error] = "There was a problem adding your entry."
					render action: 'new'
				end
	      	end
	end

	def update
		@title = current_user.titles.find(params[:id])
		@title.update_attributes!(title_params)
		if @title.save  
			respond_to do |format|
    			format.html { redirect_to titles_path, notice: "Entry was updated succesfully" }
    			format.json { render json: titles_path }
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
    tags = if params[:query].present?
      Tag.where("name LIKE '%?%'", params[:query]).map(&:name)
    else
      Tag.all.map(&:name)
    end
    render json: tags
  end

private
	def title_params
		params.require(:title).permit(:title, :title_date, :all_tags, entries_attributes: [:entry, :id, :title_id, :image_ids => []])
	end
end
