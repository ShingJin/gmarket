class Notifier < ActionMailer::Base
  default :from => "test@gmail.com"
  
  def notify
    mail(:to => "jinxin@grinnell.edu",
         :subject => "Someone commmented on your Item")
  	
  	
  end

  
end
