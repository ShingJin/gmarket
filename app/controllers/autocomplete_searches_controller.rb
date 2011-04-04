class AutocompleteSearchesController < ApplicationController


	respond_to :js

	def index
    	@some_models = SomeModel.limit(10).search_for_name(params[:term])
    	respond_with(@some_models)
	end


end
