module ApplicationHelper
 
 def sortable(column, title = nil)  
      title ||= column.titleize
      css_class = (column == sort_column) ? "current #{sort_direction}" : nil  
      direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
      link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
 end
 
 def categorizable(column, title = nil)
      title ||= Category.find(column).name.titleize
 end
 
 def pageless(total_pages, url=nil, container=nil)
  opts = {
    :totalPages => total_pages,
    :url        => url,
    :loaderMsg  => 'Loading more results'
  }
  container && opts[:container] ||= container

  javascript_tag("$('#items').pageless(#{opts.to_json});")
end


  def format_date(type, date)
    case type
      when :short_no_year 
        date.strftime("%b %d")
      when :short
        date.strftime("%b %d, %y")
      when :long 
        date.strftime("%B %d, %Y")
      when :long_day_of_week
        date.strftime("%a %B %d, %Y")
      when :default
        date.strftime("%m.%d.%Y")
    end
  end

 

 
end
