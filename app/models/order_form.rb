class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :shipping_origin_id, :city, :address_line1, :address_line2, :phone_number, :token

  validates :token, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :postal_code, presence: true,
                          format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :shipping_origin_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :city, presence: true
  validates :address_line1, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                           length: { minimum: 10, maximum: 11, message: 'is too short' }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)

      ShippingAddress.create!(order_id: order.id, postal_code: postal_code, shipping_origin_id: shipping_origin_id, city: city,
                              address_line1: address_line1, address_line2: address_line2, phone_number: phone_number)

      true
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "OrderForm save failed: #{e.message}"
    false
  end

  private

  def prevent_duplicate_errors
    errors.messages.each do |attribute, messages|
      unique_messages = messages.uniq
      errors.delete(attribute)
      unique_messages.each { |message| errors.add(attribute, message) }
    end
  end
end
