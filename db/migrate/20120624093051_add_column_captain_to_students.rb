class AddColumnCaptainToStudents < ActiveRecord::Migration
  def change
    add_column :students, :is_captain, :boolean, :default => false
    add_column :students, :is_student_union_member, :boolean, :default => false
  end
end
