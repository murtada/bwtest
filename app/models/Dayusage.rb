class Dayusage
  include ActiveModel::Validations
  extend ActiveModel::Naming
  
  attr_accessor :always_on, :heating_ac, :refrigeration, :dryer, :cooking, :other, :datetimemidpoint
end