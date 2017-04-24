class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @photo = Photo.find(params[:photo_id])
    @comment = Comment.create(comment_params.merge(photo_id: @photo.id, user_id: current_user.id))

    redirect_to photo_path(@photo)
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.find(params[:id])
    @comment.destroy

    redirect_to photo_path(@photo)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def correct_user
    @photo = Photo.find(params[:photo_id])
    unless current_user.comments.find_by_id(params[:id])
      flash[:warning] = "You didn't post this"
      redirect_to photo_path(@photo)
    end
  end
end
