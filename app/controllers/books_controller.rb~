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
				u=User.find(1).items.build
				u.name=b.title
				u.price=b.price
				u.isbn=b.isbn
				u.category_id=1
				u.show=false
				u.save
				@items << u
			end
			
		
				 	
	end
	
	
end
