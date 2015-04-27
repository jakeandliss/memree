class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @image = Image.create(images_param)
    respond_to do |format|
      if @image.save
        format.json{
          render json: @image
        }
      else

      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    respond_to do  |format|
      if @image.destroy
        format.html {redirect_to title_entries_path, notice: "Delete Successful"}
        format.js
      end
    end
  end

  private

  def images_param
    params.require(:image).permit(:avatar)
  end
end