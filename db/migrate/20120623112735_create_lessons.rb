class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :subject_id
      t.integer :teacher_id
      t.integer :klasse_id

      t.timestamps
    end
  end
end
