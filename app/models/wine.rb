class Wine < ActiveRecord::Base
	VARIETALS = ["Pinot Grigio", "Merlot", "Pinot Noir", "Shiraz", "Zinfandel", "Cabernet Sauvignon", "Chardonnay", "Pinot", "Riesling"]

	has_many :log_entries, dependent: :destroy
	
	validates :name, :year, :varietal, :winery, :country, presence: true

	validates :year, 
    numericality: { greater_than_or_equal_to: 0 },
    if: "year.present?"
    	validates :varietal, inclusion: {in: VARIETALS }

	def average_rating
		if log_entries.loaded?
			log_entries.map(&:rating).compact.average
		else
			log_entries.average(:rating)	
		end
	end	

end
