



require 'mechanize'
require 'hpricot'
require 'open-uri'
require "amazon/ecs"
require 'pp'
class Makemoney



  def self.getLink(asin)
    #visit the affliate page
     @result=""
     @address="http://rcm.amazon.com/e/cm?t=wikihowtodo-20&o=1&p=8&l=as1&asins=#{asin}&ref=tf_til&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr"
     doc = open(@address){ |f|
	 				Hpricot (f)
	 		}
      (doc/"#title/a").each do |url|
         @result=url.to_s.scan(/href="(.*)\"\ t/).flatten()
      end
      return @result
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








