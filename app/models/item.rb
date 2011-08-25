

require 'hpricot'
require 'open-uri'
require 'pp'


class Item < ActiveRecord::Base
  attr_accessible :name, :price, :picture, :description, :bs, :status, :category_id, :secondprice, :subcategory_id, :asin, :condition
  
  
  
  validates :name,  :presence   => true, :length     => { :maximum => 200 }
  validates_numericality_of :price, :message=>"is not a number"
  validates_inclusion_of :price, :in => 0..99999
  validates :description, :length     => { :maximum => 400 }

  
  
  belongs_to :category	
  belongs_to :subcategory
  belongs_to :user
  
  

   has_attached_file :picture,
	    :default_url => "/images/defaultItem2.png",
    	:styles => {
      	:thumb=> "75x75#",
      	:small  => "300x300>" },
      	:storage => :s3,
     	:bucket => 'marketplace_grinnell',
     	:s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
     	:path => "/:style/:filename"
     
    def self.getLink(number)
       
    
     for i in Item.where("id >?", number)
       pp i.id
     asin = i.asin    
    
     @address="http://rcm.amazon.com/e/cm?t=wikihowtodo-20&o=1&p=8&l=as1&asins=#{asin}&ref=tf_til&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr"
      doc = open(@address){ |f|
          Hpricot (f)
      }
      
      
      (doc/"#title/a").each do |url|
         i.link=url.to_s.scan(/href="(.*)\"\ t/).flatten().first()

      end
      
      doc2 = open(i.link) {|e|
          Hpricot (e)  
      }
      
      (doc2/".parseasinTitle/span").each do |url|
         i.name=url.inner_html
      end 
      
      (doc/"span.price").each do |url|
         i.price=url.to_s.scan(/;">\$(.*?)</).flatten().first()
         if !(i.price.nil?)
           break
         end
      end
      
          
      (doc/"span.price").each do |url|
         i.secondprice=url.to_s.scan(/e">\$(.*?)</).flatten().first()
 
       end
      
      (doc/"#content/p").each do |url|
         i.description=url.to_s.scan(/<p>(.*?)</).flatten().first()
         if !(i.description.nil?)
            break
         end 
       end
       
       (doc/"#image/a/img").each do |url|
         i.picture_path=url.to_s.scan(/"(.*?)"/).flatten().first()

       end 
       
       i.recommend = true
       i.bs = false
       i.save
      
     end 
    end

  
        	
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
  
   def self.subcategory(subcategory_id)
     if subcategory_id
       
     else
       scoped
     end   
   end
  
  
  
  
  
  
  
  
end
