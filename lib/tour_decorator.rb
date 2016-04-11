# the concret component we would like to decorate, a car in our example
class BasicTour
	def initialize(cost, language)
		@cost = cost
		@language = language
		@description = "Basic Tour"
	end
	
	# getter method
	def cost
		return @cost
	end
	
	def details
		return @description + ": #{@cost}; " + @language + "; "
	end	
end

# decorator class -- this serves as the superclass for all the concrete decorators
# the base/super class decorator (i.e. no actual decoration yet), each concrete decorator (i.e. subclass) will add its own decoration
class TourDecorator
	def initialize(real_tour)
		@real_tour = real_tour
		@extra_cost = 0
		@description = "no extra feature"
	end
	
	def cost
		return @extra_cost + @real_tour.cost
	end
	
	def details
		return @description + " " + @real_tour.details
	end
	
end


# a concrete decorator
class ElectricWindowsDecorator < TourDecorator
	def initialize(real_tour)
		super(real_tour)
		@description = "Haunted House"
		@extra_cost = 20
	end
	
	def details
		return @description + ": #{@extra_cost} + " + @real_tour.details  
	end	
end

# another concrete decorator
class MirrorDecorator < TourDecorator
	def initialize(real_tour)
		super(real_tour)
		@description = "3 Hour Walk"
		@extra_cost = 15
	end
	
	def details
		return @description + ": #{@extra_cost} + " + @real_tour.details  
	end	
end

# another concrete decorator
class ParkingSensorDecorator < TourDecorator
	def initialize(real_tour)
		super(real_tour)
		@description = "5 Hour Walk"
		@extra_cost = 20
	end
	
	def details
		return @description + ": #{@extra_cost} + " + @real_tour.details  
	end	
end

class TintedLightsDecorator < TourDecorator
	def initialize(real_tour)
		super(real_tour)
		@description = "3 Hour Bus"
		@extra_cost = 20
	end
	
	def details
		return @description + ": #{@extra_cost} + " + @real_tour.details  
	end	
end

class BrakeLightsDecorator < TourDecorator
	def initialize(real_tour)
		super(real_tour)
		@description = "Pub Crawl"
		@extra_cost = 20
	end
	
	def details
		return @description + ": #{@extra_cost} + " + @real_tour.details  
	end	
end

tour = BasicTour.new(15000, "bmw")
puts tour.cost
puts tour.details

# add extra features to the car
tour = ElectricWindowsDecorator.new(tour)
puts tour.cost
puts tour.details

tour = ParkingSensorDecorator.new(tour)
puts tour.cost
puts tour.details

tour = MirrorDecorator.new(tour)
puts tour.cost
puts tour.details

tour = TintedLightsDecorator.new(tour)
puts tour.cost
puts tour.details

tour = BrakeLightsDecorator.new(tour)
puts tour.cost
puts tour.details

