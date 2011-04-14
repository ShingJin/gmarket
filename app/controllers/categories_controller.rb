class CategoriesController < ApplicationController

   helper_method :sort_column, :sort_direction

  def show
      @items = Item.where("category_id =?",params[:id]).category(params[:category]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction).paginate(:per_page =>100, :page => params[:page])  
 	  @categories=Category.all
  end

  
  def sort_column  
     Item.column_names.include?(params[:sort]) ? params[:sort] : "created_at" 
   end  
     
   def sort_direction  
     %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc" 
   end  
   
end
