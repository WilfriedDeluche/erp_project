class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :birthdate
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :home_phone_number
      t.string :mobile_phone_number

      t.timestamps
    end
  end
end
