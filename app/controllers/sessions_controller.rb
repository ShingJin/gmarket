class SessionsController < ApplicationController  
  def create  
   auth = request.env["omniauth.auth"]  
   user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)  
   session[:user_id] = user.id
   session[:token]=auth["credentials"]["token"]
   if user.phone.nil?|user.email.nil?
      flash[:success]= "Welcome, please fill out this contact form so that buyers can reach you"
	  redirect_to edit_user_path(current_user)
   else
   	  flash[:success]= "Welcome!"
	  redirect_to '/items'
	end
  end  
  
   def destroy  
      session[:user_id] = nil  
      redirect_to '/items', :notice => "Signed out!"
   end  
end  
