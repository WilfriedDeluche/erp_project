class CreateRecruiters < ActiveRecord::Migration
  def change
    create_table :recruiters do |t|
      t.string :arrival_date

      t.timestamps
    end
  end
end
