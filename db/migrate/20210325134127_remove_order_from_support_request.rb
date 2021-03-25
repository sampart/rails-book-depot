class RemoveOrderFromSupportRequest < ActiveRecord::Migration[6.0]
  def change
    remove_column :support_requests, :order_id, :integer
  end
end
