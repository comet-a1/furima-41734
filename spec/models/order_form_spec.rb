require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  describe '購入情報の保存' do
    context '保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_form).to be_valid
      end

      it 'address_line2が空でも保存できる' do
        @order_form.address_line2 = ''
        expect(@order_form).to be_valid
      end
    end

    context '保存できない場合' do
      it 'tokenが空では保存できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では保存できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では保存できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空では保存できない' do
        @order_form.postal_code = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeにハイフンが含まれていないと保存できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it 'shipping_origin_idが0では保存できない' do
        @order_form.shipping_origin_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Shipping origin can't be blank")
      end

      it 'cityが空では保存できない' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it 'address_line1が空では保存できない' do
        @order_form.address_line1 = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address line1 can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下では保存できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is too short')
      end

      it 'phone_numberが12桁以上では保存できない' do
        @order_form.phone_number = '123456789012'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is too short')
      end

      it 'phone_numberにハイフンが含まれていると保存できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end

      it 'phone_numberが英数字混合では保存できない' do
        @order_form.phone_number = 'abc12345678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
    end
  end
end