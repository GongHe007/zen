class InitMigration < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :nickname,                   null: false
      t.string  :encrypted_password,         null: false
      t.string  :token,                      null: false
      t.string  :email,                      null: false
      t.string  :mobile_number,  limit: 20
      t.float   :eth_balance,                null: false, default: 0.0
      t.float   :eth_locked_balance,         null: false, default: 0.0

      t.timestamps
    end

    create_table :advertisements do |t|
      t.integer :user_id,                   null: false
      t.integer :_type,                     null: false
      t.integer :cryptocurrency_type,       null: false
      t.integer :legal_tender_type,         null: false
      t.float   :premium,                   null: false
      t.integer :status,                    null: false, default: 0
      t.float   :min_limit
      t.float   :max_limit
      t.float   :min_price
      t.float   :max_price
      t.integer :time_limit,                null: false
      t.boolean :alipay,                    null: false, default: false
      t.boolean :wxpay,                     null: false, default: false
      t.boolean :bankpay,                   null: false, default: false
      t.string  :alipay_number
      t.string  :wx_number
      t.string  :bank_card_number
      t.text    :remark
      t.index   :user_id
      t.index   :_type
      t.index   :cryptocurrency_type
      t.index   :legal_tender_type
      t.index   :status

      t.timestamps
    end

    create_table :orders do |t|
      t.integer :buyer_id,                  null: false
      t.integer :seller_id,                 null: false
      t.integer :advertisement_id,          null: false
      t.integer :cryptocurrency_type,       null: false
      t.integer :legal_tender_type,         null: false
      t.float   :cryptocurrency_amount,     null: false
      t.float   :legal_tender_amount,       null: false
      t.integer :status,                    null: false, default: 0
      t.float   :price,                     null: false
      t.float   :service_charge,            null: false, default: 0
      t.integer :payment
      t.integer :locked_at
      t.integer :time_limit,                null: false, default: 15
      t.boolean :buyer_checked,             null: false, default: false
      t.boolean :seller_checked,            null: false, default: false
      t.index   :buyer_id
      t.index   :seller_id
      t.index   :advertisement_id
      t.index   :cryptocurrency_type
      t.index   :legal_tender_type
      t.index   :status

      t.timestamps
    end
  end
end
