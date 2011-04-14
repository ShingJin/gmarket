class NotifierController < ApplicationController
	
	def send
		Notifier.welcome('jinxin@grinnell.edu')	
	end

end
