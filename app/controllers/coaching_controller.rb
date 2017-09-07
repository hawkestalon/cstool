class CoachingController < ApplicationController
  def new
    @coach = Coach.new
    @user = User.find(params[:id])
  end

  def create
    @coach = Coach.new(user_params)
    @user = User.find(params[:id])
    if @coach.save
      flash[:success] = "Coaching Session Saved"
      redirect_to "/coaching/show?id=#{@user.id}"
    else
      flash[:danger] = "Not saved, Unknown Error"
    end
  end

  def edit
    @coach = Coach.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def show
    @user = User.find(params[:id])
    @coaching = Coach.where(:user_id => params[:id])
  end

  private
  def user_params
    params.require(:coach).permit(:details, :goals, :reminder, :user_id)
  end
end
