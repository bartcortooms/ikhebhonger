class Restaurant < ActiveRecord::Base
	RATING_TYPES = [
		[ '1 vorkje', 1 ],
		[ '2 vorkjes', 2 ],
		[ '3 vorkjes', 3 ],
		[ '4 vorkjes', 4 ],
	]

	PRICING_TYPES = [
		[ 'Cheap', 1 ],
		[ 'Average', 2 ],
		[ 'Above average', 3 ],
		[ 'Luxurious', 3 ],
	]

	validates_presence_of  :city_id
	validates_presence_of  :name

	belongs_to :city
	belongs_to :food_type

	def geocoordinates
		return [self.lat, self.lon]
	end

	def fetch_geocoordinates
		results = Geocoding::get("#{self.address} #{self.city} Netherlands")
		if results.status == Geocoding::GEO_SUCCESS
			self.lat = results[0].latitude.to_f
			self.lon = results[0].longitude.to_f
		end
		return [self.lat, self.lon]
	end
end
