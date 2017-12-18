class ApplicationController < ActionController::Base
  #includes the helper functions from the various helper files.
  protect_from_forgery with: :exception
  include SessionsHelper
  include AttrecordHelper
  include MissHelper
end
