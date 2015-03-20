class TitlesController < ApplicationController

	def index
		@titles = Title.all
		@title = Title.new
		@title.entries.build
	end

	def show
		@title = Title.find(params[:id])

	end

	def edit
		@title = Title.find(params[:id])
	end

	def create
  		@title = Title.new(title_params)
  		if @title.save  
  			flash[:notice] = "Entry was created succesfully" 
  			redirect_to @title
  		else 
  			flash[:alert] = "Entry has not been created"
  		end
	end

	def update
		@title = Title.find(params[:id])
		@title.update_attributes!(params[:id])

	end

	def destroy
		@title = Title.find(params[:id])
		@title.destroy
		flash[:alert] = "Entry has been deleted"
		redirect_to titles_path
	end

private
	def title_params
		params.require(:title).permit(:title, :title_date, entries_attributes: [:entry, :id, :title_id])
	end
end
