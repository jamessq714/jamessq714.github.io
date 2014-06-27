class Story < ActiveRecord::Base
	
	validates :title, :category, :link, presence: true
	# validates :title, length: {minimum: 5}
	validates :link, :format => URI::regexp(%w(http https))

	def self.search_for(query)
		where('title LIKE :query or category LIKE :query', query: "%#{query}%")
	end
end
