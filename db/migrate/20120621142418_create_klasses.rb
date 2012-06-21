class CreateKlasses < ActiveRecord::Migration
  def change
    create_table :klasses do |t|
      t.integer :training_id
      t.integer :year

      t.timestamps
    end
  end
end
