class TitlesController < ApplicationController

	def index
		@titles = Title.all
		@title = Title.new
		@title.entries.build

	end

	def edit
		@title = Title.find(params[:id])
	end

	def create
  		@title = Title.new(title_params)
  		if @title.save  
  			flash[:notice] = "Entry was created succesfully" 
  			redirect_to title_entries_path(@title)
  		else 
  			flash[:alert] = "Entry has not been created"
  		end
	end

	def update
		@title = Title.find(params[:id])
		@title.update_attributes!(title_params)
		if @title.save  
  			flash[:notice] = "Entry was updated succesfully" 
  			redirect_to title_entries_path(@title)
  		else 
  			flash[:alert] = "Entry has not been updated"
  		end

	end

	def destroy
		@title = Title.find(params[:id])
		@title.destroy
		flash[:notice] = "Entry has been deleted"
		redirect_to titles_path
	end

private
	def title_params
		params.require(:title).permit(:title, :title_date, entries_attributes: [:entry, :id, :title_id])
	end
end
