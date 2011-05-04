class PagesController < ApplicationController



	def search
		@books=Book.department(params[:department])
	end
end
