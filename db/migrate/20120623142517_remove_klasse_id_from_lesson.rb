class RemoveKlasseIdFromLesson < ActiveRecord::Migration
  def up
    remove_column :lessons, :klasse_id
  end

  def down
    add_column :lessons, :klasse_id, :integer
  end
end
