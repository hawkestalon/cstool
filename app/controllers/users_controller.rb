class UsersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show]
  before_action :correct_user, only: [:new, :create, :show, :myTeam]

  def new
    if logged_in?
      @user = User.new
    else
      flash[:danger] = "Please Login First"
      redirect_to "/login"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.attrecords.create(PTO: 0, FMLA: 0, days: 3)
      flash[:success] = "User Created"
      # redirect_to @user
      render 'new'
    else
      render 'new'
    end
  end

  def show
      @user = User.find(params[:id])
      @verbal = @user.corrective.where(:typeOf=>"Verbal Warning").count
  end

  def myTeam
    if current_user.role != 0
      @users = User.where(:team => current_user.team).order(:name)
    else
      @users = User.order(:name)
    end
  end

  def teamChart
    @leads = User.where(:role => 2)
    @team = User.group(:team).count
    # array of users by team
    @users = []
    @team.each do |key, value|
      temp = User.where(:team => key)
      @users.push(temp)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:sucess] = "Successfully Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :role, :team, :password, :certLevel, :employee, :password_confirmation)
    end
end
