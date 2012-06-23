class CreateKlassesSubjectsJoin < ActiveRecord::Migration
  def up
    create_table 'klasses_subjects', :id => false do |t|
      t.column :subject_id, :integer
      t.column :klass_id, :integer
    end
  end

  def down
    drop_table 'klasses_subjects'
  end
end
