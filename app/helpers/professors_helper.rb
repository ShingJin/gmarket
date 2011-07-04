
module ProfessorsHelper


  def generateChart
    

    return GoogleChart.pie_with_size_blah_blah_600x400('year 1997'=>10,'year 1998'=>20,'year 1999'=>15,'year 2000'=>55).to_url

    
  end


end
