class ContactFormsController < ApplicationController
  def new 
  	@contact_form = ContactForm.new 
  end 

  def create 
  	begin 
  		@contact_form = ContactForm.new(params[:contact_form])
  		@contact_form.request = request 
  		respond_to do |format|
  			if @contact_form.deliver 
  				format.js
  				format.html {redirect_to entries_path, notice: "Feedback sent. Thank you!"}
  			else render :new
  			end
  		end 
  	end 
  end 
end