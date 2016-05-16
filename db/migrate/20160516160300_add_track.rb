class AddTrack < ActiveRecord::Migration
  def change
  	create_table :messages do |t|
	  	t.string :song_title
	  	t.string :author
	  	t.string :url
		end
  end
end
