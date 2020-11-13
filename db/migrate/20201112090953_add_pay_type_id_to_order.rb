class AddPayTypeIdToOrder < ActiveRecord::Migration[6.0]
  def up
    change_table :orders do |t|
      t.references :pay_type, null: true, foreign_key: true
    end
  end
 
  def down
    remove_column :orders, :pay_type_id
  end
end
