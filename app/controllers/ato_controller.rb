class AtoController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy]

  #atoToMiss helper function is found in the Miss helper file and will create a Missed
  #hours record for any ATO that is in the past. This function is triggered on the create
  #and show action of this controller.
  def new
    @user = User.find(params[:id])
  end

  #Should this method also subtract the PTO from a user's attrecord?
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
    #atoToMiss function is found the Miss Helper file.
    atoToMiss(@user)
  end

  def edit
    @ato = Ato.find(params[:id])
  end

  def update
    @ato = Ato.find(params[:id])
    if @ato.update(user_params)
      flash[:success] = "Approved Time Off Update Complete"
      redirect_to root_path
    else 
      flash[:danger] = "Update Failed"
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    if Ato.exists?(:user_id => @user.id)
      @ato = Ato.where(:user_id => @user.id)
    else 
      @ato = nil
    end
    #atoToMiss function is found the Miss Helper file.
    atoToMiss(@user)
  end

  def destroy
    @ato = Ato.find(params[:id])
    if @ato.delete
      flash[:success] = "Aprroved Time Off Deleted"
    else
      flash[:danger] = "Error. Approved Time Off Not Deleted"
    end
  end

  private
  def user_params
      params.require(:ato).permit(:a_date, :reason, :hours)
  end
end
