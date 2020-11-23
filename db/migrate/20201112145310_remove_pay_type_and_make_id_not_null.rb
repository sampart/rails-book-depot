class RemovePayTypeAndMakeIdNotNull < ActiveRecord::Migration[6.0]
  def up
    connection.execute(%Q{
      update orders
      set pay_type_id = (
        case pay_type
          when 1 then (select id from pay_types where pay_types.description = "Check")
          when 2 then (select id from pay_types where pay_types.description = "Credit card")
          when 3 then (select id from pay_types where pay_types.description = "Purchase order")
        end
      );
    })
    change_column :orders, :pay_type_id, :integer, null: false, foreign_key: true
    remove_column :orders, :pay_type, :integer
  end

  def down
    add_column :orders, :pay_type, :integer
    # To illustrate different ways of approaching this, here's the reverse
    # migration using three updates rather than a case statement
    # For comparing performance of different queries, use EXPLAIN statements
    connection.execute(%Q{
      update orders
      set pay_type = 1
      where pay_type_id = (select id from pay_types where pay_types.description = "Check")
    })
    connection.execute(%Q{
      update orders
      set pay_type = 2
      where pay_type_id = (select id from pay_types where pay_types.description = "Credit card")
    })
    connection.execute(%Q{
      update orders
      set pay_type = 1
      where pay_type_id = (select id from pay_types where pay_types.description = "Purchase order")
    })
    change_column :orders, :pay_type_id, :integer, null: true, foreign_key: true
  end
end
