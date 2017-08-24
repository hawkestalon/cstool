class AnnouncementsController < ApplicationController
  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = Announcement.new(user_params)
    if @announcement.save
      flash[:success] = "Announcment Saved"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def delete
  end
  private
  def user_params
    params.require(:announcement).permit(:body, :date)
  end
end
