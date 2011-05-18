class BooksController < ApplicationController




    


	def index
	

		
		if params[:course]
			if params[:section]
				@books=Book.department(params[:department]).course(params[:course]).section(params[:section])
			else
				@books=Book.department(params[:department]).course(params[:course])
			end
	 	else
	 		@books=Book.department(params[:department])
	 	end
	
		@items=[]
	

			
			for b in @books
				u=current_user.items.build
				u.name=b.department+" "+b.course+": "+b.title
				u.price=b.price
				u.bs=false
				u.isbn=b.isbn
				u.category_id=1
				u.show=false
				u.save
				@items << u
			end
			
		
				 	
	end
	
	
end
