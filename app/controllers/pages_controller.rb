class PagesController < ApplicationController



	def search
		@books=Book.department(params[:department])
  end

  def constructing
    render :layout => 'welcome'
  end

end
