require 'csv'

class UsagesController < ApplicationController
  
  def index
    
    # Read all the lines into array of arrays
    @day_usage_history = CSV.read("data.csv")
    @legend = @day_usage_history.shift
    
    @heating_ac = Array.new
    @refrigeration = Array.new
    @dryer = Array.new
    @cooking = Array.new
    @other = Array.new
    @midpoint = Array.new
    
    @day_usage_history.each do |row|
      @heating_ac << [Time.parse(row[6]).to_i * 1000, row[1].to_f]
      @refrigeration << [Time.parse(row[6]).to_i * 1000, row[2].to_f]
      @dryer << [Time.parse(row[6]).to_i * 1000, row[3].to_f]
      @cooking << [Time.parse(row[6]).to_i * 1000, row[4].to_f]
      @other << [Time.parse(row[6]).to_i * 1000, row[5].to_f]
    end
    
    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(
        :zoomType =>'x',
        :defaultSeriesType => 'spline',
        :height => 800
      )
      
      f.title(:text => 'Electricity Usage')
      
      f.xAxis(
        :type => "datetime",
        :dateTimeLabelFormats => {
          second: '%H:%M:%S',
          minute: '%H:%M',
          hour: '%H:%M',
          day: '%e. %b',
          week: '%e. %b',
          month: '%b \'%y',
          year: '%Y'
        },
        :title => {
          :text => "6-hour midpoint (UTC)"
        }
      )
      
      f.yAxis(
        :min => 0,
        :title => {
          :text => "total appliance-level energy consumed (kwh)"
        }
      )
      
      f.scrollbar(
        :enabled => true
      )
      
      f.series(:name=>'Heating & A/C', :data=>@heating_ac)
      f.series(:name=>'Refrigeration', :data=>@refrigeration)
      f.series(:name=>'Dryer', :data=>@dryer)
      f.series(:name=>'Cooking', :data=>@cooking)
      f.series(:name=>'Other', :data=>@other)
      
    end
    
  end
  
end