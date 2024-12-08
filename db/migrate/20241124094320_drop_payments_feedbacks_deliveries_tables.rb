class DropPaymentsFeedbacksDeliveriesTables < ActiveRecord::Migration[7.2]
  def change
    drop_table :payments, if_exists: true
    drop_table :feedbacks, if_exists: true
    drop_table :deliveries, if_exists: true
  end
end
