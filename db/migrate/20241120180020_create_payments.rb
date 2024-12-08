class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.decimal :total_amount
      t.string :status
      t.string :payment_method

      t.timestamps
    end
  end
end
