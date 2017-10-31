class StaticController < ApplicationController
  #this gets the announcements in order by their created date
  #not the updated_at date. If user is not logged in, it redirects
  #to the login page. 
  def home
    @announcements = Announcement.order(created_at: :desc)
    if !logged_in?
      redirect_to login_path
    end
  end
end
