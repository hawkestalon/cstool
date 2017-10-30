class StaticController < ApplicationController
  def home
    @announcements = Announcement.order(created_at: :desc)
    if !logged_in?
      redirect_to login_path
    end
  end
end
