class CreateKlassesStudentsJoin < ActiveRecord::Migration
  def up
    create_table 'klasses_students', :id => false do |t|
      t.column :klass_id, :integer
      t.column :student_id, :integer
    end
  end

  def down
    drop_table 'klasses_students'
  end
end
