class AddTrack < ActiveRecord::Migration
  def change
  	create_table :tracks do |t|
	  	t.string :song_title
	  	t.string :author
	  	t.string :url
		end
  end
end
