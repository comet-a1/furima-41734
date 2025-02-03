FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    category_id { 1 }
    price { 1 }
    condition_id { 1 }
    shipping_fee_id { 1 }
    shipping_origin_id { 1 }
    shipping_days_id { 1 }
  end
end
