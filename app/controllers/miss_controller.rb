class MissController < ApplicationController
  def new
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
  end

  def destroy
  end
end
