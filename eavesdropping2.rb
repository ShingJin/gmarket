require 'rubygems'
require 'hpricot'
require 'open-uri'


class Eavesdropping


	attr_accessor :address, :digits
	
	
    def initialize
		@address="http://bookstore.grinnell.edu/textbooks_xml.asp?control=section&section="
		@digits=1949..2261
	end

	
	def test

		@digits.each do |d|
		
			addr=@address+d.to_s
				
			doc = open(addr){ |f|
	 			Hpricot (f)
	 		}	 	
	 		(doc/"#course-bookdisplay-coursename").each do |name|	 
				name=name.inner_html
				
				
				
				
			end	
			(doc/".book-title").each do |title|	 
				puts title.inner_html			
			end	
			
	
		end
		
	
	end 

end