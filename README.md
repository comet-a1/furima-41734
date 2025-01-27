# テーブル設計


## users テーブル

| Column                 | Type     | Options                                  |
| ---------------------- | -------- | ---------------------------------------- |
| name                   | string   | null: false                              |
| nickname               | string   | null: false                              |
| email                  | string   | null: false, unique: true                |
| encrypted_password     | string   | null: false                              |
| birth_date             | date     |                                          |
| reset_password_token   | string   | unique: true                             |
| reset_password_sent_at | datetime |                                          |
| remember_created_at    | datetime |                                          |
| created_at             | datetime | null: false                              |
| updated_at             | datetime | null: false                              |

### Association

- has_many :orders
- has_many :shipping_addresses


## orders テーブル

| Column              | Type     | Options                                  |
| ------------------- | -------- | ---------------------------------------- |
| user_id             | bigint   | null: false, foreign_key: true           |
| product_id          | string   | null: false, foreign_key: true           |
| quantity            | string   | null: false, unique: true                |
| total_price         | string   | null: false                              |
| status              | date     | null: false, default: "pending"          |
| shipping_address_id | bigint   | null: false, foreign_key: true           |
| ordered_at          | datetime | null: false                              |
| created_at          | datetime | null: false                              |
| updated_at          | datetime | null: false                              |

### Association

- belongs_to :user
- belongs_to :shipping_address
- has_many :order_items


## shipping_addresses テーブル

| Column        | Type     | Options                                  |
| ------------- | -------- | ---------------------------------------- |
| user_id       | bigint   | null: false, foreign_key: true           |
| postal_code   | string   | null: false,                             |
| prefecture_id | string   | null: false, foreign_key: true           |
| city          | string   | null: false                              |
| address_line1 | date     | null: false                              |
| address_line2 | bigint   |                                          |
| phone_number  | datetime |                                          |
| created_at    | datetime | null: false                              |
| updated_at    | datetime | null: false                              |

### Association

- belongs_to :user
- belongs_to :prefecture
- has_many :orders


## products テーブル

| Column          | Type     | Options                                  |
| --------------- | -------- | ---------------------------------------- |
| name            | string   | null: false                              |
| description     | text     | null: false                              |
| category_id     | bigint   | null: false, foreign_key: true           |
| price           | decimal  | null: false, precision: 10, scale: 2     |
| condition       | string   | null: false                              |
| shipping_fee    | decimal  | null: false, precision: 10, scale: 2     |
| shipping_origin | string   | null: false                              |
| shipping_days   | string   | null: false                              |
| image_url       | string   |                                          |
| created_at      | datetime | null: false                              |
| updated_at      | datetime | null: false                              |

### Association

- belongs_to :category
- has_many :order_items


## prefectures テーブル

| Column     | Type     | Options                                  |
| ---------- | -------- | ---------------------------------------- |
| name       | string   | null: false, unique: true                |
| name_kana  | string   | null: false, unique: true                |
| region     | string   | null: false                              |
| created_at | datetime | null: false                              |
| updated_at | datetime | null: false                              |

### Association

- has_many :shipping_address(optional if shipping_origin is used directly)


## categories テーブル

| Column      | Type     | Options                                  |
| ----------- | -------- | ---------------------------------------- |
| name        | string   | null: false, unique: true                |
| description | text     |                                          |
| parent_id   | bigint   | foreign_key: true                        |
| created_at  | datetime | null: false                              |
| updated_at  | datetime | null: false                              |

### Association

- has_many :products
- belongs_to :parent, class_name: "Category", optional: true
- has_many :children, class_name: "Category", foreign_key: "parent_id"


## order_items テーブル

| Column     | Type     | Options                                  |
| ---------- | -------- | ---------------------------------------- |
| order_id   | bigint   | null: false, foreign_key: true           |
| product_id | bigint   | null: false, foreign_key: true           |
| quantity   | integer  | null: false                              |
| price      | decimal  | null: false, precision: 10, scale: 2     |
| subtotal   | decimal  | null: false, precision: 10, scale: 2     |
| created_at | datetime | null: false                              |
| updated_at | datetime | null: false                              |

### Association

- belongs_to :order
- belongs_to :product




<!-- This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->
