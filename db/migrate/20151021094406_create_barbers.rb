class CreateBarbers < ActiveRecord::Migration
  def change
	create_table :barbers do |t|
		t.text :name
		
		t.timestamps null: false
	end
	
	Barber.create :name => 'Goe Gig'
	Barber.create :name => 'DoeGoe Gig'
	Barber.create :name => 'Siew Gog'
	
  end
end
