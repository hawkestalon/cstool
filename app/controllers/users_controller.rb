class UsersController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :show]
  before_action :correct_user, only: [:new, :create, :show, :myTeam]

  #check to make sure user is logged in before rendering page
  #create a new user object
  #redirect to login if user is not logged in.
  def new
    if logged_in?
      @user = User.new
    else
      flash[:danger] = "Please Login First"
      redirect_to "/login"
    end
  end

  #create new user and an associated attendance record with default values
  #on success display new user page and a success message
  #else we display the new user page and an error message
  def create
    @user = User.new(user_params)
    if @user.save
      @user.attrecords.create(PTO: 0, FMLA: 0, days: 3)
      flash[:success] = "User Created"
      render 'new'
    else
      flash[:danger] = "Error! User not Created"
      render 'new'
    end
  end

  #find the desired user by its id number from a url parameter
  #get number of corrective actions of type verbal warning
  def show
      @user = User.find(params[:id])
      @verbal = @user.corrective.where(:typeOf=>"Verbal Warning").count
  end

  #if current user is just a lead, display only users on their team
  #in alphabetical order
  #if current user is admin, display all users
  def myTeam
    if current_user.role != 0
      @users = User.where(:team => current_user.team).order(:name)
    else
      @users = User.order(:name)
    end
  end

  #@leads stores all users with the role lead
  #@team is the amount of different teams
  #@users is a multi dimensional array of users
  #each new row in array is a new team
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

  #get user object to be edited with url parameter as id of user
  def edit
    @user = User.find(params[:id])
  end

  #update user and if successfully update redirect to user. 
  #else render the edit page again. (Possible bug here?)
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:sucess] = "Successfully Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  #restrict parameters that can be accepted into the active record
  #any parameter labeled different than those below will not be saved
  private
    def user_params
      params.require(:user).permit(:name, :email, :role, :team, :password, :certLevel, :employee, :password_confirmation)
    end
end
