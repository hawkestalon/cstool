class AnnouncementsController < ApplicationController
=begin
This controller contains the methods for creating, updating,
and deleting announcements.
This controller contains only basic methods that work as you would expect. 
=end
  def new
    @announcement = Announcement.new
  end

  #Create a new announcement. If successful create a success message
  #and redirect to the root page which is where the announcements
  #reside.
  def create
    @announcement = Announcement.new(user_params)
    if @announcement.save
      flash[:success] = "Announcement Saved"
      redirect_to root_path
    else
      render 'new'
    end
  end

  #find the announcement to be edited 
  def edit
    @announcement = Announcement.find(params[:id])
  end

  #Save changes that were made. Rerender the edit page
  #if changes were unsuccessful, otherwise, redirect to 
  #root
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

  #delete the announcement
  def delete
    @announcement = Announcement.find(params[:id])
    @announcement.delete
    redirect_to root_path
  end
  
  #this is a private method that only allows certain parameters to be passed into 
  #the active record database objects. 
  private
  def user_params
    params.require(:announcement).permit(:body, :date)
  end
end
