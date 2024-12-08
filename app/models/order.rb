class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :name, presence: { message: "Fullname is required." }
  validates :email, presence: { message: "Email is required." }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format." }
  validates :phone, presence: { message: "Phone number is required." }, format: { with: /\A\+?[\d\s\-()]+\z/, message: "Invalid phone number format." }
  validates :address, presence: { message: "Address is required." }
  validates :delivery_method, presence: { message: "Please select a delivery method." }
  validates :payment_method, presence: { message: "Please select a payment method." }

  # Optional field validations
  validates :delivery_address, length: { maximum: 255, message: "Delivery address is too long (maximum 255 characters)." }, allow_blank: true
  validates :comment, length: { maximum: 500, message: "Comment is too long (maximum 500 characters)." }, allow_blank: true

end
