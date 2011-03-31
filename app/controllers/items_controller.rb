class ItemsController < ApplicationController

   helper_method :sort_column, :sort_direction


  def index
      @items = Item.category(params[:category]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction).paginate(:per_page =>20, :page => params[:page])  
  end

  def show	
    @item = Item.find(params[:id])
  	@user = User.find(@item.user_id)
	@pic_url="http://graph.facebook.com/"+@user.uid.to_s+"/picture"
  end

  def new
    @item = Item.new
  end

  def new_sell
  
  	if current_user
  		@item = Item.new
  			if params[:search]
  				@item.name=params[:search]
  			end
  		@item.bs = 0
  		@item.status = 0
  	else
  		redirect_to '/'
  	end
  end
  
  
  def new_buy
  
  	if current_user
    	@item = Item.new
			if params[:search]
  				@item.name=params[:search]
  			end
		@item.bs = 1
 		@item.status = 0
  	else
  		redirect_to '/'
  	end
  end


  def create
    @item = current_user.items.new(params[:item])
    if @item.save
      redirect_to '/items', :notice => "Successfully created item."
    else
   		if @item.bs==false
   			render :action => 'new_sell'
   		else
   			render :action => 'new_buy'
   		end
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to '/items', :notice  => "Successfully updated item."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_url, :notice => "Successfully destroyed item."
  end
  
  
  
  
  def sort_column  
     Item.column_names.include?(params[:sort]) ? params[:sort] : "created_at" 
   end  
     
   def sort_direction  
     %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
   end  
  
  
end
