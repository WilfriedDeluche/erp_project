class AddDateAndTimeToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :start_date, :datetime
    add_column :lessons, :end_date, :datetime
  end
end
