class Post < ActiveRecord::Base
	belongs_to :user
	validates :message, presence: true
  validates :message, length: {maximum: 140, 
too_long: "A Post is only 140 max. Everybody knows that!"}

geocoded_by :address
 after_validation :geocode

acts_as_votable

 def score
  self.get_upvotes.size - self.get_downvotes.size
end


 def address
 	"#{destination}"
end
 def self.search(search)
  where("name LIKE ?", "%#{search}%") 
  where("content LIKE ?", "%#{search}%")
end

end
