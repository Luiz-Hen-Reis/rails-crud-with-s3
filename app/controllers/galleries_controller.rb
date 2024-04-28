class GalleriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_gallery, only: [:show,:destroy]

  def index
    @galleries = @user.galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def  new
    @gallery = Gallery.new
  end

  def create
    @gallery = @user.galleries.build(gallery_params)
    if @gallery.save
      redirect_to galleries_path, notice: 'Galeria criada com sucesso.'
    else
      render :new
    end
  end

  def destroy
    @gallery.destroy
    redirect_to galleries_path, notice: 'Galeria excluída com sucesso!'
  end

  private

  def set_gallery
    @gallery = @user.galleries.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def gallery_params
    params.require(:gallery).permit(:title, images: [])
  end
end
