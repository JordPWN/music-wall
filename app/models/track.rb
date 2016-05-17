class Track < ActiveRecord::Base
	belongs_to :user
	
	has_many :reviews
	has_many :upvotes

	validates :song_title, presence: true, length: { maximum: 40 }
  validates :artist, presence: true, length: { maximum: 25 }
end