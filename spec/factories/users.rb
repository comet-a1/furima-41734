FactoryBot.define do
  factory :user do
    nickname { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { 'a1b2c3' }
    password_confirmation { 'a1b2c3' }
    birth_date { Faker::Date.birthday }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
  end
end
