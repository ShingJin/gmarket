class Notifier < ActionMailer::Base
  default :from => "238357@gmail.com"
  
  def notify
    mail(:to => "jinxin@grinnell.edu",
         :subject => "Someone commmented on your Item")
  	
  	
  end

  
end
