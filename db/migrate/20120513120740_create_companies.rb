class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :corporate_name
      t.string :address
      t.integer :zip_code
      t.string :city
      t.string :phone_number
      t.string :contact_first_name
      t.string :contact_last_name
      t.string :contact_email

      t.timestamps
    end
  end
end
