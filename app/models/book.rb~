require 'rubygems'
require 'open-uri'
require 'hpricot'




class Book < ActiveRecord::Base





  def self.department(department)
  	if department
  	   where(:department=>department)
  	else
  	  scoped
  	end
  end
  
  def self.course(course)
  	if course
  	   where(:course=>course)
  	else
  	  scoped
  	end
  end

  def self.section(section)
  	if section
  	   where(:section=>section)
  	else
  	  scoped
  	end
  end


	def self.scrape
		@address="http://bookstore.grinnell.edu/textbooks_xml.asp?control=section&section="
		@digits=2039..2261

	
			@digits.each do |d|
				
				puts d			
				
				addr=@address+d.to_s
				
				doc = open(addr){ |f|
	 				Hpricot (f)
	 			}	 	
	 			(doc/"#course-bookdisplay-coursename").each do |name|	 
					buffer=name.inner_html				
					(doc/".book-desc").each do |desc|
						
						
						@book=Book.new
						@book.title=desc.to_s.scan(/book-title">(.*?)</)
						@book.isbn=desc.to_s.scan(/"isbn">(.*?)</)
						@book.department=buffer.scan(/\A(.*?) -/)
						@book.course=buffer.scan(/- (.*?),/)
						@book.section=buffer.scan(/section (.*?) /).flatten.first.to_i
 						@book.price=searchPrice(@book.isbn)
 						@book.save

					end		
						
				end					
			end
			
			
	end

	def self.searchPrice(isbn)
		
		doc = open("http://www.google.com/search?q=#{isbn}&tbs=shop%3A1&aq=f"){ |f|
	 		Hpricot (f)
		}			
		if doc.to_s.scan(/"psliprice"><b>\$(.*?)</)==[]
			return 0
		else 
			return doc.to_s.scan(/"psliprice"><b>\$(.*?)</).first.first.to_i
		end
	end





end
