class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_origin
  belongs_to :shipping_day, foreign_key: 'shipping_days_id'

  validate :image_presence
  validates :name, presence: true
  validates :description, presence: true

  validates :price, presence: true, numericality: { only_integer: true, message: 'is not a number' }
  validates :price, numericality: { greater_than_or_equal_to: 300,
                                    message: 'must be greater than or equal to 300' },
                    if: lambda {
                      price.present?
                    }
  validates :price, numericality: { less_than_or_equal_to: 9_999_999,
                                    message: 'must be less than or equal to 9,999,999' },
                    if: lambda {
                      price.present?
                    }

  validates :category_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_fee_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_origin_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_days_id, numericality: { other_than: 0, message: "can't be blank" }

  private

  def image_presence
    errors.add(:base, "Image can't be blank") unless image.attached?
  end

  def prevent_duplicate_errors
    errors.messages.each do |attribute, messages|
      unique_messages = messages.uniq
      errors.delete(attribute)
      unique_messages.each { |message| errors.add(attribute, message) }
    end
  end
end
