class CreateOrdersSupportRequestsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :orders, :support_requests
  end
end
