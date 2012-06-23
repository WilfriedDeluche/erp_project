class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :student_id
      t.integer :subject_id
      t.float :grade
      t.float :scale

      t.timestamps
    end
  end
end
