class MissController < ApplicationController
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
