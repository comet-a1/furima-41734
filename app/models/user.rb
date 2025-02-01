class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  validates :birth_date, presence: true

  validates :password, presence: true,
                       format: {
                         with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/,
                         message: 'is invalid. Include both letters and numbers'
                       }
  validates :password, confirmation: true

  validates :last_name, presence: true,
                        format: { with: /\A[一-龯ぁ-んァ-ンー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true,
                         format: { with: /\A[一-龯ぁ-んァ-ンー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ンー]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ンー]+\z/, message: 'is invalid. Input full-width katakana characters' }

  validates :email, presence: true, uniqueness: true

  validates :encrypted_password, presence: true, unless: -> { new_record? }

  validate :prevent_duplicate_errors

  private

  def prevent_duplicate_errors
    errors.messages.each do |attribute, messages|
      unique_messages = messages.uniq
      errors.delete(attribute)
      unique_messages.each { |message| errors.add(attribute, message) }
    end
  end
end
