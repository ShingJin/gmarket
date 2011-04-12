class CategoriesController < ApplicationController


  def show
      @items = Item.where("category_id =?",params[:id]).category(params[:category]).search(params[:search],params[:bs]).order(sort_column + ' ' + sort_direction).paginate(:per_page =>20, :page => params[:page])  
 	  @categories=Category.all
  end

end
