namespace :db do

  desc "change"


    task :update_dates => :environment do

    	for i in Item.all
    		i.updated_at=i.updated_at+3.months
    		i.created_at=i.created_at+3.months
    		i.save

    	end

    end
end