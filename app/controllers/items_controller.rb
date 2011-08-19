class ItemsController < ApplicationController

   helper_method :sort_column, :sort_direction


  def update_all
  	params[:items].each do |key,value|
  	
  		if params[:item_ids].nil?
  				i=Item.find(key)
				i.destroy
		else
  	
  			if	!(params[:item_ids][key.to_s].nil?)
  				i=Item.find(key)
  				i.show=true
				i.price=value["price"]
				i.condition=value["condition"]
				i.save
			else
				i=Item.find(key)
				i.destroy
			end
		end
  	end 
  	
  	redirect_to root_path
  end
  
  def index
      @items = Item.where("show =?",true).where("recommend =?",false).where("category_id IS NOT NULL").category(params[:category]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction).paginate(:per_page =>50, :page => params[:page])  
 	  @categories=Category.all

 end

  def show	
    @item = Item.find(params[:id])
  	@title="Grinnell College Marketplace - "+@item.name.titleize
  	@user = User.find(@item.user_id)
	@pic_url="http://graph.facebook.com/"+@user.uid.to_s+"/picture"
	@current_url="http://www.thegmarket.me/items/"+@item.id.to_s

  end

  def notify
    @item = Item.find(params[:id])
  	Notifier.notify(@item).deliver
  	redirect_to @item
  end



  def new
    @item = Item.new
  end

def subcategories_by_category
  if params[:id].present?
    @subcategories = Category.find(params[:id]).subcategories
  else
    @subcategories = []
  end
 
  respond_to do |format|
    format.html
    format.js
  end

end

  def new_sell
      @categories=Category.all
      @subcategories=Subcategory.all
  	#if current_user
  		@item = Item.new
  			if params[:search]
  				@item.name=params[:search]
  			end
  		@item.bs = 0
  		@item.status = 0
  	#else
  	#	flash[:success] = "Please sign in first :)"
  	#	redirect_to '/items'
  	#end
  end
  def new_buy
        @categories=Category.all
      @subcategories=Subcategory.all
  	#if current_user
    	@item = Item.new
			if params[:search]
  				@item.name=params[:search]
  			end
		@item.bs = 1
 		@item.status = 0
  	#else
  	#	flash[:success] = "Please sign in first :)"
  	#	redirect_to '/items'
  	#end
  end


  def create
    #@item = current_user.items.new(params[:item])
    @item = User.find(1).items.new(params[:item])
    if @item.save
      flash[:success] = "Your item is posted"
      begin
        redirect_to '/items', :success => "Your item is posted"

      rescue
       redirect_to '/items', :success => "Your item is posted"

      end
    else
   		if @item.bs==false
   			render :action => 'new_sell'
   		else
   			render :action => 'new_buy'
   		end
    end
  end
  
  
  
 def fpublish(name,bs,number)
 
	user =  FbGraph::User.fetch('me', :access_token => session[:token])
  	
  	if bs==false
  		message="#{current_user.name} just listed the item '#{name}' on Gmarket"
  	else
  		message="#{current_user.name} wants to buy #{name}"
  	end
  	
  	
  	user.feed!(
    :message => message,
    :name => 'thegmarket.me',
    :link => 'http://www.thegmarket.me/items/'+number.to_s,
    :description => 'Gmarket is a free online marketplace for Grinnell College students'
    )
 end
  
  
  
  

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to '/items', :notice  => "Successfully updated your item."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_url, :notice => "Successfully deleted your item."
  end
  
  
  
  
  def sort_column  
     Item.column_names.include?(params[:sort]) ? params[:sort] : "created_at" 
   end  
     
   def sort_direction  
     %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
   end  
  
  
end
