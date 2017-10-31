class AttrecordController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user, only: [:edit, :update]
=begin
The logged_in_user and correct_user functions can be found
in the sessions helper file. 

Attrecord contains a lot of information that is best updated partially.
Flexes updated on their own.
PTO/FMLA/3Days updated together. 
The attrecord database should only have one record per user. This simplifies
a lot of the maintenance and retrieving records. This may make it difficult
to keep long term records, if they are needed. 

Optimizations have not been made. 
=end
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

    def link
        if current_user.role == 0
          @users = User.all.order(:name)
        else
          @users = User.where(:team => current_user.team).order(:name)
        end
    end

    def flexes
        @user = User.find(params[:id])
        @att = @user.attrecords.first
    end

    def pto
        @user = User.find(params[:id])
        @att = @user.attrecords.first
    end

    private
        def att_params
            params.require(:attrecord).permit(:flexone, :flextwo, :flexthree, :PTO, :FMLA, :days)
        end
end
