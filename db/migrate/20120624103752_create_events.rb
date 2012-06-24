class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.string :location
      t.integer :student_id
      t.integer :klass_id
      t.text :description

      t.timestamps
    end
  end
end
