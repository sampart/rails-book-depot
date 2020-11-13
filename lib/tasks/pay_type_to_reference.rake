namespace :db do
  desc "Adds an appropriate pay_type_id to orders based on pay_type"
  task :migrate_pay_type => :environment do
    all_orders = Order.all
    all_orders.each do |order|
      # sqlite> select * from pay_types;
      # 2|Check|2020-11-11 09:05:38.885558|2020-11-11 09:05:38.885558
      # 3|Credit card|2020-11-11 09:05:38.888682|2020-11-11 09:05:38.888682
      # 4|Purchase order|2020-11-11 09:05:38.891736|2020-11-11 09:05:38.891736
      case order.pay_type
      when "Check"
        order.pay_type_id = 2
      when "Credit card"
        order.pay_type_id = 3
      when "Purchase order"
        order.pay_type_id = 4
      else
        puts "Order #{order.id} had invalid pay type #{order.pay_type.inspect}"
      end
      order.save!
    end
    puts "Migrated #{all_orders.size} orders"
  end
end
