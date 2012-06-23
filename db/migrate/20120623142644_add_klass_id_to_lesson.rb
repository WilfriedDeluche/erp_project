class AddKlassIdToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :klass_id, :integer
  end
end
