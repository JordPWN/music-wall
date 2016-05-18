class User < ActiveRecord::Base
	has_many :tracks
	has_many :upvotes
	has_many :reviews

	def has_voted?(track)
		!!self.upvotes.find_by(track_id: track.id)
	end
end