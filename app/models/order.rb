class Order < ApplicationRecord
  belongs_to :user
  belongs_to :driver

  validates :customer_name, presence: true
  validates :origin, :destination, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  enum :status, { pending: 0, scheduled: 1, in_progress: 2, delivered: 3 }
end
