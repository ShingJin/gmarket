class Notifier < ActionMailer::Base
  default :from => "238357@gmail.com"
  
  def welcome
    mail(:to => "jinxin@grinnell.edu",
         :subject => "is now the symbol with the highest stock factor!")
  end

  
end
