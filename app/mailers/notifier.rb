class Notifier < ActionMailer::Base
  default :from => "238357@gmail.com"
  
  def welcome(recipient)
    @account = recipient
    mail(:to => recipient,
         :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"])
  end

  
end
