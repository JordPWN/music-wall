class AddTrack < ActiveRecord::Migration
  def change
  	create_table :tracks do |t|
	  	t.string :song_title
	  	t.string :artist
	  	t.integer :rating
	  	t.string :url
	  	t.references :user
		end

		create_table :users do |t|
			t.string :username
			t.string :email
			t.string :password
		end

		create_table :upvotes do |t|
			t.references :user
			t.references :track
			t.integer :score
		end
		create_table :reviews do |t|
			t.references :user
			t.references :track
			t.integer :rating
			t.string :content
		end
  end
end
