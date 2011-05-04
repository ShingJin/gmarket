namespace :db do

  desc "change"

    


    task :add_books => :environment do
    
    for b in Book.all
        b.destroy  
    end  
         Book.scrape
    end

  desc "show"

    task :add_show => :environment do
    	 
	for i in Item.all
	    i.show=true
	    i.save
	end

    end
  


end