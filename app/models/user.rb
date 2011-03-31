class User < ActiveRecord::Base  
  
  has_many :items, :dependent => :destroy
  
  validates :email,   
             :uniqueness => true,   
             :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i } 

  validates :phone, :length     => { :maximum => 15 }
  
  def self.create_with_omniauth(auth)  
     create! do |user|  
     user.provider = auth["provider"]  
     user.uid = auth["uid"]  
     user.name = auth["user_info"]["name"]  
	 user.email=auth["extra"]["user_hash"]["email"]
   end  
  end  

 end  