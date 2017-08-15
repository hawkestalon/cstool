module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    def logged_in?
        !current_user.nil?
    end
    def correct_user
      unless current_user.role == 0 || current_user.role == 2
        @user = User.find(params[:id])
        redirect_to(root_url) unless @user == current_user
      end
    end
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please Log In"
        redirect_to login_url
      end
    end    
end
