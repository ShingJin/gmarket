class CategoriesController < ApplicationController

   helper_method :sort_column, :sort_direction

  def show
    if(params[:subcategory])
      @items = Item.where("subcategory_id =?",params[:subcategory]).where("category_id =?",params[:id]).where("show =?",true).category(params[:category]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction)
 	  else
 	    @items = Item.where("category_id =?",params[:id]).where("show =?",true).category(params[:category]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction)  
 	  end
 	    @categories=Category.all
  end



def subcategories_by_category
  if params[:id].present?
    @subcategories = Category.find(params[:id]).subcategories
  else
    @subcategories = []
  end
 
  respond_to do |format|
    format.js
  end

end


  
  def sort_column  
     Item.column_names.include?(params[:sort]) ? params[:sort] : "created_at" 
   end  
     
   def sort_direction  
     %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
   end  
   
   
   def index
   @items = Item.where("show =?",true).where("category_id IS NOT NULL").category(params[:category]).subcategory(params[:subcategory]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction).paginate(:per_page =>50, :page => params[:page])  
    @categories=Category.all
   end
   
end
