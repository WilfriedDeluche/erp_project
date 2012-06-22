class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.string :name
      t.string :section
      t.string :level

      t.timestamps
    end
  end
end
