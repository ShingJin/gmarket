class Item < ActiveRecord::Base
  attr_accessible :name, :price, :description, :bs, :status, :category


  def self.search(search,bs)  
     if search  
       where('name LIKE ?', "%#{search}%").where(:bs=>bs)  
     else  
       scoped  
     end  
  end  	

  def self.category(category)
  	if category
  	   where(:category=>category)
  	else
  	  scoped
  	end
  end
  
end
