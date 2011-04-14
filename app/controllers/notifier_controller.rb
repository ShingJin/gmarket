class NotifierController < ApplicationController
	
	def send
		Notifier.welcome
	end

end
