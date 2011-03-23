class ItemsController < ApplicationController

   helper_method :sort_column, :sort_direction


  def index
      @items = Item.category(params[:category]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 5, :page => params[:page])  
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def new_sell
  	@item = Item.new
  	@item.bs = 0
  	@item.status = 0
  end
  
  
  def new_buy
    @item = Item.new
	@item.bs = 1
 	@item.status = 0
  end


  def create
    @item = Item.new(params[:item])
    if @item.save
      redirect_to '/items', :notice => "Successfully created item."
    else
      render :action => 'new'
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
     Item.column_names.include?(params[:sort]) ? params[:sort] : "name" 
   end  
     
   def sort_direction  
     %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc" 
   end  
  
  
end
