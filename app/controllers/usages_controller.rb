class UsagesController < ApplicationController
  
  def index
    
    # Read all the lines into array of arrays
    all_lines = CSV.read("data.csv")
    
    @day_usage_history = Array.new
    
    all_lines.each do |line|
      @day_usage_history << line
    end
    
  end
  
end