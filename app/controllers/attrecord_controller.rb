class AttrecordController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user, only: [:edit, :update]

    def edit
        @user = User.find(params[:id])
        @att = @user.attrecords.first
    end
    def update
        @user = User.find(params[:id])
        att = @user.attrecords.first
        if att.update_attributes(att_params)
            if params[:flex] == "None"
                flash[:success] = "Flex Updated Successfully"
                redirect_to @user
            else
                #figure out how to show different messages depending on what's updated
                flash[:success] = "Attendance Updated Successfully"
                redirect_to @user
            end
        else 
            flash[:danger] = "There was an error"
            render 'edit'
        end
    end
    private
        def att_params
            params.require(:attrecord).permit(:flexone, :flextwo, :flexthree, :PTO, :FMLA, :days)
        end
end
