class Notifier < ActionMailer::Base
  default :from => "from@example.com"
  
  def welcome(recipient)
    @account = recipient
    mail(:to => recipient,
         :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"])
  end

  
end
