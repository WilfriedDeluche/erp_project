class AddIsTestToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :is_test, :boolean
  end
end
