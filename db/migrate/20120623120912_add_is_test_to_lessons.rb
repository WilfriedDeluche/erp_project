class AddIsTestToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :is_test, :boolean, :default => false
  end
end
