require 'rubygems'
require 'open-uri'
require 'hpricot'

class ISBNScrap
	def initialize (isbn)
		@urlAmazon="http://www.amazon.com/s/&url=search-alias=stripbooks?field-keywords=#{isbn}"
	end

	def searchAmazon
		puts "Scrapped URL: "+@urlAmazon
		begin
			doc = Hpricot(open(@urlAmazon))
			keywords = doc.at("meta[@name='keywords']")['content'].split(',')
			puts "Title: "+keywords[0]
			puts "Author: "+keywords[1]

			price=(doc/"table.product//tr//td/b.price").inner_html
			puts "Price: "+price if (not price.nil?)

			buckets=(doc/"table//td.bucket//li").each { |bucket|
				info=bucket.at("b").inner_html
				info= info.gsub("\n", "")
				print info
				# some cleaning up: removes <b>, <a> tags,  , \n
				# we just need the text
				(bucket/"b").remove
				(bucket/"a").remove
				valueTxt=bucket.inner_html.gsub("\n", "").gsub("\ ", "")
				# regexp/splitting for really messy html
				if (info =~/Average/)
					rate = valueTxt.scan(/"(.+)stars\-(\d\-\d)\.(.+)"/)
					puts $2
				elsif (info =~ /Sales/)
					rank=valueTxt.split
					puts rank[0]
				else
					puts valueTxt
				end
			}
		rescue
			puts "Err: "+$!
			puts "Trace:"
			$@.each {|tl| 	puts tl }
		end
	end
end

isbn = (ARGV[0].nil?)?'0451167716':ARGV[0] # if argv[0] is null, defaults to the bible of correct social behavior

isbnScrap = ISBNScrap.new(isbn)

isbnScrap.searchAmazon
