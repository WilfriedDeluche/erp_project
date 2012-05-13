class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.integer :student_id
      t.integer :recruiter_id
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
