class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :event_id
      t.integer :student_id

      t.timestamps
    end
  end
end
