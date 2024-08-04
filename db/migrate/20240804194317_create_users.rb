class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.timestamps
    end
    add_reference :customers, :user, foreign_key: true
  end
end
