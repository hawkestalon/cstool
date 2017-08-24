class StaticController < ApplicationController
  def home
    @announcements = Announcement.all
  end
end
