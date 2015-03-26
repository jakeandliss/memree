class TitlesController < ApplicationController
	before_action :require_user
	
	def index
		@titles = current_user.titles.all
		@title = current_user.titles.new
		@title.entries.build
		if params[:tag]
			@titles = current_user.titles.tagged_with(params[:tag])
		else
			@titles = current_user.titles.all
		end
	end

	def edit
		@title = current_user.titles.find(params[:id])
	end

	def create
  		@title = current_user.titles.new(title_params)
  		if @title.save  
  			flash[:notice] = "Entry was created succesfully" 
  			#render plain: params[:title].inspect
  			redirect_to title_entries_path(@title)
  		else 
  			flash[:error] = "There was a problem adding your entry."
  			render action: 'new'
  		end
	end

	def update
		@title = current_user.titles.find(params[:id])
		@title.update_attributes!(title_params)
		if @title.save  
  			flash[:notice] = "Entry was updated succesfully" 
  			redirect_to title_entries_path(@title)

  		else 
  			flash[:error] = "Entry has not been updated"
  			render action: 'edit'
  		end

	end

	def destroy
		@title = current_user.titles.find(params[:id])
		@title.destroy
		flash[:notice] = "Entry has been deleted"
		redirect_to titles_path
	end

private
	def title_params
		params.require(:title).permit(:title, :title_date, :all_tags, entries_attributes: [:entry, :id, :title_id])
	end
end
