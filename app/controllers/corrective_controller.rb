class CorrectiveController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy]
  def new
    @user = User.find(params[:id])
  end
  def print
    @corr = Corrective.find(params[:id])
    render "shared/_print", :layout=>false
  end

  def create
    @user = User.find(params[:id])
    @corrective = @user.corrective.build(user_params)
    if current_user.authenticate(params[:corrective][:supsig])
      if @corrective.save
        @corrective.update(supervisor: current_user.name, supsig: "Authenticated")
        flash[:success] = "Corrective Action Completed"
        redirect_to @user
      else
        flash[:danger] = "Error in Submission"
        render 'new'
      end
    else
      flash[:danger] = "Signature(s) Incorrect"
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def link
    if current_user.role == 0
      @users = User.all.order(:name)
    else
      @users = User.where(:team => current_user.team).order(:name)
    end
  end

  def edit
    @corr = Corrective.find(params[:id])
    if @corr.user.id != current_user.id || current_user.role == 0
      flash[:danger] = "Permission Denied!"
      redirect_to current_user
    end
  end
  def update
    @corr = Corrective.find(params[:id])
    user = @corr.user
    if user.authenticate(params[:corrective][:agentsig])
      if @corr.update(user_params)
        @corr.update(agentsig: "Signed")
        flash[:success] = "Corrective Action Update Completed!"
        redirect_to @corr.user
      else 
        flash[:danger] = "Error in Submission"
        render 'new'
      end
    else
      flash[:danger] = "Signature Incorrect"
      render 'edit'
    end
  end
  private
    def user_params
        params.require(:corrective).permit(:date_of, :supervisor, :description, :date, :plan, :action, :comments, :typeOf)
    end
end
