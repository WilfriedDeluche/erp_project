class RemovePositionFromSchoolUser < ActiveRecord::Migration
  def up
    remove_column :school_users, :position
  end

  def down
    add_column :school_users, :position, :string
  end
end
