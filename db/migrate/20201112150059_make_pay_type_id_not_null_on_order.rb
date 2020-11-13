class MakePayTypeIdNotNullOnOrder < ActiveRecord::Migration[6.0]
  def up
    change_column :orders, :pay_type_id, :integer, null: false, foreign_key: true
  end

  def down
    change_column :orders, :pay_type_id, :integer, null: true, foreign_key: true
  end
end
