class Notifier < ActionMailer::Base
  default :from => "238357@gmail.com"
  
  def notify(item)
    @user = User.find(item.user_id)
    @url="http://www.thegmarket.me/items/"+item.id
    mail(:to => "jinxin@grinnell.edu",
         :subject => "Someone commmented on your Item") do |format|
      	  format.html { render 'notify_email' }
    end
  	
  	
  end

  
end
