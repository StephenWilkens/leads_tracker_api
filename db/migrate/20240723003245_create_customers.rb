class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :county
      t.string :state
      t.string :point_of_contact
      t.string :contact_information
      t.string :zip_code
      t.string :last_check_in
      t.date :next_check_in
      t.text :notes
      t.integer :interest_level
      t.string :bar
      t.boolean :liquor_store

      t.timestamps
    end
  end
end
