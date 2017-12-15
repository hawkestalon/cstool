class UsersController < ApplicationController
  require 'csv'
  before_action :logged_in_user
  before_action :correct_user, only: [ :show, :myTeam]
  before_action :admin_test, only: [:new, :create, :edit, :update, :csv, :csvFinal, :csvUser]
  #before action functions can be found in the sessions_helper file

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
      @att = @user.attrecords.first
      @coachCount = Coach.where(:user_id => @user.id).count
      @coach = Coach.where(:user_id => @user.id).order(:created_at).first
      @corrective = @user.corrective.order(:created_at).first
      @ato = @user.ato.order(:created_at).last
      reset_flexes(@user)
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
      temp = User.where(:team => key).order(role: :desc)
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
    if @user.update(user_params)
      flash[:sucess] = "Successfully Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def csvUser 
    
  end

  def csv
    @file = params[:csv][:upload]
    @file_contents = @file.read
    @content = CSV.parse(@file_contents)
    headers = ["name", "email", "employee number", "role", "team", "password", "cert level"]
    @args = []
    @content[0].each_with_index do |header, index|
      header.downcase!.lstrip!
      headers.each_with_index do |h, i|
        if header == h
          @args.push([h, index])
          headers.delete_at(i)
        end
      end
    end
    @missing_headers = headers
    redirect = false
    @missing_headers.each do |x|
      if x == "name" or x == 'email' or x == "password"
        flash[:danger] == nil ? flash[:danger] = x.capitalize : flash[:danger] += ", #{x.capitalize}"
        redirect = true
      end
    end
    if redirect
      flash[:danger] += " column headers are missing."
      redirect_to "/user/csv"
    end
    @args = @args.join(', ')
    @content.delete_at(0)
  end

  def csvFinal
    content = CSV.parse(params[:content])
    content.delete_at(0)
    args = params[:args].split(',')
    @errors = []
    @errors_why = []
    @success = []
    content.each_with_index do |entry, hash_index|
      params = Hash.new
      args.each_with_index do |arg, index|
        if index % 2 == 0 and index + 1 <= args.size
          arg = "employee" if arg.lstrip == "employee number"
          arg = "certLevel" if arg.lstrip == "cert level" or arg.lstrip == "certification level"
          params[arg.lstrip] = entry[args[index + 1].to_i]
          @errors_why.push("#{arg.lstrip.capitalize} field empty") if entry[args[index + 1].to_i] == nil and (arg.lstrip == "password" or arg.lstrip == "name" or arg.lstrip == "email")
        end
      end
      params["password_confirmation"] = params["password"]
      user = User.new(params)
      if user.save
        @success.push(params["name"])
      else
        @errors.push(params["name"])
      end
    end
  end

  def password
    @user = User.find(params[:id])
  end
  def confirm
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:danger] = "Hey now, you're not allowed to change this password."
      redirect_to @user
      return
    end
    if @user.authenticate(params[:user][:old_password]) and user_params[:password] == user_params[:password_confirmation]
      if @user.update(user_params)
        flash[:success] = "Password Changed Successfully!"
        redirect_to @user
      else 
        flash[:danger] = "Errors!"
      end
    elsif user_params[:password] == user_params[:password_confirmation]
      flash[:danger] = "Password and Password Confirmation don't match!"
      redirect_to "/users/password/?id=#{@user.id}"
    else
      flash[:danger] = "Password Incorrect"
      redirect_to "/users/password/?id=#{@user.id}"
    end
  end

  #restrict parameters that can be accepted into the active record
  #any parameter labeled different than those below will not be saved
  private
    def user_params
      params.require(:user).permit(:name, :email, :role, :team, :password, :certLevel, :employee, :password_confirmation)
    end
end
