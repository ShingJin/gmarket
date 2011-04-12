/* Eavesdropping.rb 
 * Author:Xin
 * a eavesdropping program that filters the XML messages, generator included 
*/




require 'rubygems'
require 'hpricot'


e=Eavesdropping.new
e.generator(1000)
e.filter


class Eavesdropping
 
  attr_accessor :user, :keywords, :subject, :body, :messages

  /* This function initializes the object */
  def initialize
    @user={["jack","jack johnson","jack black"]=>1,["john","john anbor","john john"]=>2,["james","james pork","james something"]=>3,["george","geroge A","george B","george whatever"]=>4,["lisa","liz","salad"]=>5,["xin","jinxin","Dr Xin"]=>6}
    @keywords=["prosser","kloppenburg","wisoncsin","federal","charlie sheen", "radio","shalke"]
    @subject=["subject1","subject2","subject3","subject4","subject4"]
    @body=["body1","body2","body3","body4","body5","body6"]
    @messages=[]
  end


  /* This function generates random messages */
  def generator(t)
  
    @messages=[]
    t.times{ |i|
    
    /* generate random numbers for different tags */
      ru=rand(@user.length)+1
      namelist=@user.index(ru)
      rn=rand(namelist.length)
      rs=rand(@subject.length)
      rk1=rand(@keywords.length)
      rk2=rand(@keywords.length)
      rk3=rand(@keywords.length)
      rk4=rand(@keywords.length)
      rb=rand(@body.length)
    
 	/* format the message */
 	  message ="<message id=#{i}>\n<sender>\n  <name>#{namelist[rn]}</name>\n  <id>#{ru}</id>
</sender>\n<subject>\n#{@subject[rs]}\n</subject>\n<keyword>#{@keywords[rk1]}</keyword>\n<keyword>#{@keywords[rk2]}</keyword>\n<keyword>#{@keywords[rk3]}</keyword>\n<keyword>#{@keywords[rk4]}</keyword>\n<body>\n#{@body[rb]}\n</body>\n</message>"
      @messages<<message
    }
              
  end   

  /* This function filters messages based on frequency and specific user_id.
  	User names asscociated with that id and top 5 keywords will be displayed */
  	 
  	 
  def filter(frequency,user_id)
    
    keywords={}
	usernames={}

    for i in 0..(@messages.length-1) do 
      
      if (i%frequency==0)
        xml=@messages[i]
        doc = Hpricot(xml)
        
        /* extract information within message tags and keyword tags */
        (doc/"message").each do |message|
          if (message/"sender"/"id").inner_html.to_i==user_id    
          	(message/"name").each do |name|
          		usernames[name.inner_html]=true		          	
          	end
          
            (message/"keyword").each do|keyword|
         		k=keyword.inner_html.to_s
         		if keywords[k]==nil
         			keywords[k]=1
         		else
         			keywords[k]=keywords[k]+1
         		end            
            end
          end
        end
      end
      
    end
    
     usernames.each do |key,value|
     	puts key
     end
     sorted=keywords.sort {|a,b| b[1]<=>a[1]}
	 puts sorted[1..5]
 
 end
  



end
