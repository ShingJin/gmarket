class Vendor < ActiveRecord::Base
  
  def self.new(category,subcategory,asin) 
    i=Item.new(:category_id=>category,:subcategory_id=>subcategory,:asin=>asin,:price=>1)
    i.save
  end  
    
   
  
  
  
end