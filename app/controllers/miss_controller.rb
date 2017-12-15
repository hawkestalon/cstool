class MissController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy]
  def new
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:id])
    @miss = @user.miss.build(user_params)
    if @miss.save
      flash[:success] = "Added Missed Hours!"
      redirect_to @user
    else 
      flash[:danger] = "Errors! The Horror!"
      render new
    end
  end

  def edit
    @miss = Miss.find(params[:id])
  end

  def update
    @miss = Miss.find(params[:id])
    if @miss.update(user_params)
      flash[:success] = "Successfully Updated!"
      redirect_to '/attendance'
    else
      flash[:danger] = "Danger! Wasn't successfully updated!"
      redirect_to '/attendance'
    end
  end

  def show
    @user = User.find(params[:id])
    atoToMiss(@user)
    if Miss.exists?(:user_id => @user.id)
      @miss = Miss.where(:user_id => @user.id)
    else 
      @miss = nil
    end
  end

  def destroy
    @miss = Miss.find(params[:id])
    @miss.delete
    redirect_to '/attendance'
  end

  private
  def user_params
      params.require(:miss).permit(:a_date, :reason, :hours)
  end
end
