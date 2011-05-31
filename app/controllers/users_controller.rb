class UsersController < ApplicationController
  	before_filter :authenticate, :only => [:edit, :update]
  	before_filter :correct_user, :only => [:edit, :update]

	def edit
	    @user = User.find(params[:id])			
	end
	
	def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Your Profile is updated."
      redirect_to 'items/index'
	  redirect_to edit_user_path(current_user)
    end
  end
	
	private
    def authenticate
      deny_access unless current_user
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user
    end
    

	

end
