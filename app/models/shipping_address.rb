class ShippingAddress < ApplicationRecord
  belongs_to :order

  validates :postal_code, presence: { message: "can't be blank" },
                          format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :shipping_origin_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :city, presence: { message: "can't be blank" }
  validates :address_line1, presence: { message: "can't be blank" }
  validates :phone_number, presence: { message: "can't be blank" },
                           format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' },
                           length: { minimum: 10, maximum: 11, message: 'is too short' }

  private

  def prevent_duplicate_errors
    errors.messages.each do |attribute, messages|
      unique_messages = messages.uniq
      errors.delete(attribute)
      unique_messages.each { |message| errors.add(attribute, message) }
    end
  end
end
