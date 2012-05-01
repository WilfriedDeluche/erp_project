class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :arrival_year

      t.timestamps
    end
  end
end
