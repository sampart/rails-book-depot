class SupportMailbox < ApplicationMailbox
  def process
    customer_orders = Order.where(email: mail.from_address.to_s).
                         order('created_at desc')

    req = SupportRequest.create!(
      email: mail.from_address.to_s,
      subject: mail.subject,
      body: mail.body.to_s
    )

    req.orders = customer_orders
    req.save!
  end
end
