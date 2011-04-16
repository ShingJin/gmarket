class Notifier < ActionMailer::Base
  default :from => "238357@gmail.com"
  
  def notify(item)
    @user = User.find(item.user_id)
    @email=@user.email
    @url="http://www.thegmarket.me/items/"+item.id.to_s
    mail(:to => @email
         :subject => "Someone commmented on your Item") do |format|
      	  format.html { render 'notify_email' }
    end
  	
  	
  end

  
end
