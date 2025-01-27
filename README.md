# テーブル設計


## users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |
| last_name_kana     | string   | null: false               |
| first_name_kana    | string   | null: false               |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| birth_date         | date     |                           |

### Association

- has_many :orders
- has_many :products


## orders テーブル

| Column              | Type     | Options                        |
| ------------------- | -------- | ------------------------------ |
| user_id             | bigint   | null: false, foreign_key: true |
| product_id          | bigint   | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :product


## shipping_addresses テーブル

| Column        | Type     | Options                        |
| ------------- | -------- | ------------------------------ |
| user_id       | bigint   | null: false, foreign_key: true |
| postal_code   | string   | null: false                    |
| prefecture    | string   | null: false                    |
| city          | string   | null: false                    |
| address_line1 | string   | null: false                    |
| address_line2 | string   |                                |
| phone_number  | string   |                                |

### Association

- belongs_to :user


## products テーブル

| Column          | Type     | Options     |
| --------------- | -------- | ----------- |
| name            | string   | null: false |
| description     | text     | null: false |
| category        | string   | null: false |
| price           | integer  | null: false |
| condition       | string   | null: false |
| shipping_fee    | integer  | null: false |
| shipping_origin | string   | null: false |
| shipping_days   | string   | null: false |

### Association

- belongs_to :user
- has_one :order







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
