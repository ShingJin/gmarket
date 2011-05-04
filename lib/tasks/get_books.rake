namespace :db do

  desc "change"

    
    task :destroy_books => :environment do
    
    for b in Book.all
    	puts b.id
    	b.destroy
    end

    end


    task :add_books => :environment do
      
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