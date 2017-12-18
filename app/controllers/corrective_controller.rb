class CorrectiveController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:new, :create, :destroy]
  def new
    @user = User.find(params[:id])
  end

  #this action puts the action in a format that can be printed
  def print
    @corr = Corrective.find(params[:id])
    render "shared/_print", :layout=>false
  end

  def create
    @user = User.find(params[:id])
    @corrective = @user.corrective.build(user_params)
    #checks to see if the sup signed it the corrective action.
    if current_user.authenticate(params[:corrective][:supsig])
      if @corrective.save
        #updates the record to indicate who signed it and that it was signed. 
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

  #edit and update methods are for the agent signing the action
  #and adding their comments. You can only edit the corrective action
  #if the user_id is the same as the corrective user_id.
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
