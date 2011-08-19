



require 'mechanize'
require 'hpricot'
require 'open-uri'
require "amazon/ecs"
require 'pp'
class Makemoney



  def self.getLink(asin)
    
    
    
     i=Item.find(488)
       
         
    
     @address="http://rcm.amazon.com/e/cm?t=wikihowtodo-20&o=1&p=8&l=as1&asins=#{asin}&ref=tf_til&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr"
      doc = open(@address){ |f|
	 				Hpricot (f)
	 		}
      (doc/"#title/a").each do |url|
         i.link=url.to_s.scan(/href="(.*)\"\ t/).flatten()
      end
      
      (doc/"#title/a").each do |url|
         i.name=url.inner_html
      end 
      
      (doc/"span.price").each do |url|
         i.price=url.to_s.scan(/;">(.*?)</).flatten()
      end
      
          
      (doc/"span.price").each do |url|
         i.secondprice=url.to_s.scan(/e">(.*?)</).flatten()
       end
      
      (doc/"#content/p").each do |url|
         i.description=url.to_s.scan(/<p>(.*?)</).flatten()
       end
       
       (doc/"#image/a/img").each do |url|
         i.picture_path=url.to_s.scan(/"(.*?)"/).flatten()
       end 
       
       i.recommended = true
       
       i.save
      
      
    end


    #parse the response


    #return the address

  def self.returnDetail(word)

    result = []
    Amazon::Ecs.configure do |options|
        options[:aWS_access_key_id] = "AKIAICDXU5SXRWQA5RQA"
        options[:aWS_secret_key] = "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"
    end

    res = Amazon::Ecs.item_search(word, :sort => "salesrank")

    if (res.has_error?)||(res.is_valid_request?)
     #return something
    end

    asin = res.items.first.get('ASIN')
    result << Makemoney.getLink(asin)
    url = res.items.first.get('DetailPageURL')
    doc = open(url){ |f|
	 				Hpricot (f)
	 	}

     (doc/".olpCondLink/.price").each do |l|
           result << l.inner_html
      end


    return result.flatten

  end


end


pp Makemoney.returnDetail("9780979905285")








