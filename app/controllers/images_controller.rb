class ImagesController < ApplicationController
  before_action :authenticate_user!
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
    if @image.destroy
      render json: {success: true}
    end
  end

  private

  def images_param
    params.require(:image).permit(:avatar)
  end
end