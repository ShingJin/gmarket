require 'rubygems'
require 'hpricot'

class Eavesdropping
 
  attr_accessor :user, :keywords, :subject, :body, :messages

  def initialize
    @user={"jack"=>1,"john"=>2,"james"=>3,"george"=>4,"lisa"=>5,"xin"=>6}
    @keywords=["prosser","kloppenburg","wisoncsin","federal","charlie sheen", "radio","shalke"]
    @subject=["subject1","subject2","subject3","subject4","subject4"]
    @body=["body1","body2","body3","body4","body5","body6"]
    @messages=[]
  end

  def generator(t)
  
    @messages=[]
    t.times{ |i|
      ru=rand(@user.length)+1
      rs=rand(@subject.length)
      rk1=rand(@keywords.length)
      rk2=rand(@keywords.length)
      rk3=rand(@keywords.length)
      rk4=rand(@keywords.length)
      rb=rand(@body.length)
      message ="<message id=#{i}>\n<sender>\n  <name>#{@user.index(ru)}</name>\n  <id>#{ru}</id>
</sender>\n<subject>\n#{@subject[rs]}\n</subject>\n<keyword>#{@keywords[rk1]}</keyword>\n<keyword>#{@keywords[rk2]}</keyword>\n<keyword>#{@keywords[rk3]}</keyword>\n<keyword>#{@keywords[rk4]}</keyword>\n<body>\n#{@body[rb]}\n</body>\n</message>"
      @messages<<message
    }
              
  end   


  def filter(frequency,user_id)
    
    keywords={}


    for i in 0..(@messages.length-1) do 
      
      if (i%frequency==0)
        xml=@messages[i]
        doc = Hpricot(xml)
        (doc/"message").each do |message|
          if (message/"sender"/"id").inner_html.to_i==user_id            
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
     sorted=keywords.sort {|a,b| b[1]<=>a[1]}
	 puts sorted[1..5]
  end
  



end
