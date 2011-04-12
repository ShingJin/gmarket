class Item < ActiveRecord::Base
  attr_accessible :name, :price, :description, :bs, :status, :category_id, :secondprice
  
  
  
  validates :name,  :presence   => true, :length     => { :maximum => 70 }
  validates_numericality_of :price, :message=>"is not a number"
  validates_inclusion_of :price, :in => 0..99999
  validates :description, :length     => { :maximum => 400 }


  
  
  belongs_to :category	
  belongs_to :user
  
  

   has_attached_file :photo,
    	:styles => {
      	:thumb=> "100x100#",
      	:small  => "300x300>" },
      	:storage => :s3,
     	:s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
     	:path => "/:style/:filename"
        	
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
