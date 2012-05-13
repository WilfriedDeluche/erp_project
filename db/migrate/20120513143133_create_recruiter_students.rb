class CreateRecruiterStudents < ActiveRecord::Migration
  def change
    create_table :recruiter_students do |t|
      t.integer :student_id
      t.integer :recruiter_id
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
