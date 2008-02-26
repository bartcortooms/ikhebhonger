class City < ActiveRecord::Base
	has_many :restaurants

	def to_s
		name
	end
end
