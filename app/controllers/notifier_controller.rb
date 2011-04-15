class NotifierController < ApplicationController
	
	def send
		Notifier.welcome.deliver
	end

end
