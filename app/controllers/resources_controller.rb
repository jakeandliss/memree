class ResourcesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create

    @resource = Resource.new(resource_param)
    @resource.entry_id = params[:entry_id] if params[:entry_id].present?

    if @resource.save
      respond_to do |format|      
        format.json {render json: @resource}
      end
    end
  end

  def destroy


    @resource = Resource.find(params[:id])

    if @resource.destroy
      respond_to do  |format|
        format.html {redirect_to entries_path, notice: "Delete Successful"}
        format.js
      end
    end
  end

  private

  def resource_param
    params.require(:resource).permit(:avatar)
  end
end
