class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :student_id
      t.integer :company_id
      t.integer :recruiter_id
      t.date :start_date
      t.date :end_date
      t.string :kind

      t.timestamps
    end
  end
end
