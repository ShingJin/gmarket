namespace :db do

  desc "change"

    


    task :add_books => :environment do
    
    for b in Book.all
        b.destroy  
    end  
         Book.scrape
    end
end