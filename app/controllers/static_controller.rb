class StaticController < ApplicationController
  def home
    @announcements = Announcement.order(created_at: :desc)
  end
end
