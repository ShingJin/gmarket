class Notifier < ActionMailer::Base
  default :from => "238357@gmail.com"
  
  def welcome(recipient)
    @account = recipient
    mail(:to => recipient,
         :subject => "#{symbol} is now the symbol with the highest stock factor!")
  end

  
end
