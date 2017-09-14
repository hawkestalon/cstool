class AtoController < ApplicationController
  def new
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:id])
    @ato = @user.ato.build(user_params)
    if @ato.save
      flash[:success] = "Approved Time Off Added"
      render 'new'
    else
      flash[:danger] = "Oh no! Something went wrong!"
      render 'new'
    end
  end

  def edit
    @ato = Ato.find(params[:id])
  end

  def update

  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end
  private
  def user_params
      params.require(:ato).permit(:a_date, :reason, :hours)
  end
end
