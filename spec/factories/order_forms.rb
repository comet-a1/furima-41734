FactoryBot.define do
  factory :order_form do
    user_id { Faker::Number.non_zero_digit }
    item_id { Faker::Number.non_zero_digit }
    postal_code { '123-4567' }
    shipping_origin_id { 1 }
    city { 'Tokyo' }
    address_line1 { 'aoyama 1-1-1' }
    address_line2 { 'Building A' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
