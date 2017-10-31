class AnnouncementsController < ApplicationController
=begin
This controller contains the methods for creating, updating,
and deleting announcements.
This controller contains only basic methods that work as you would expect. 
=end
  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(user_params)
    if @announcement.save
      flash[:success] = "Announcement Saved"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update(user_params)
      flash[:success] = "Announcement Updated"
      redirect_to root_path
    else
      flash[:danger] = "Uh oh, No joy. "
      render 'edit'
    end
  end

  def delete
    @announcement = Announcement.find(params[:id])
    @announcement.delete
    redirect_to root_path
  end
  
  private
  def user_params
    params.require(:announcement).permit(:body, :date)
  end
end
