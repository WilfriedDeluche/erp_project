class CreateSubjectsTeachersJoin < ActiveRecord::Migration
  def up
    create_table 'subjects_teachers', :id => false do |t|
      t.column :subject_id, :integer
      t.column :teacher_id, :integer
    end
  end

  def down
    drop_table 'subjects_teachers'
  end
end
