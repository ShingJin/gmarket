class Item < ActiveRecord::Base
  attr_accessible :name, :price, :description, :bs, :status, :category_id, :secondprice
  
  
  
  validates :name,  :presence   => true, :length     => { :maximum => 70 }
  validates_numericality_of :price, :message=>"is not a number"
  validates_inclusion_of :price, :in => 0..99999
  validates :description, :length     => { :maximum => 400 }


  
  
  belongs_to :category	
  belongs_to :user
  
  

  
  def self.search(search,bs)  
     if search  
       where('LOWER(name) LIKE ?', "%#{search.downcase}%").where(:bs=>bs)  
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
