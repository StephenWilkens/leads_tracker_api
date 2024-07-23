class ChangeDataTypeForBar < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :bar
    add_column :customers, :bar, :boolean
  end
end
