class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.all.order(created_at: :desc)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = current_user.photos.build
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.save

    redirect_to photos_path
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.update(photo_params)

    redirect_to @photo
  end

  def destroy
    @photo = Photo.find (params[:id])
    @photo.destroy

    redirect_to photos_path
  end

  private
  def photo_params
    params.require(:photo).permit(:image, :caption)
  end

  def correct_user
    unless current_user.photos.find_by_id(params[:id])
      flash[:warning] = "You didn't post this"
      redirect_to root_path
    end
  end
end
