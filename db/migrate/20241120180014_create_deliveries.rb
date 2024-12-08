class CreateDeliveries < ActiveRecord::Migration[7.2]
  def change
    create_table :deliveries do |t|
      t.string :name
      t.decimal :cost
      t.string :estimated_delivery_time

      t.timestamps
    end
  end
end
