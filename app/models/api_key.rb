class ApiKey < ApplicationRecord
  belongs_to :user

  validates :key, presence: true, uniqueness: true
  validates :expires_at, presence: true
  validate :expires_at_must_be_in_the_future

  before_validation :generate_unique_key, on: :create

  private

  def generate_unique_key
    self.key ||= loop do
      generated_key = SecureRandom.hex(10)
      break generated_key unless ApiKey.exists?(key: generated_key)
    end
  end

  def expires_at_must_be_in_the_future
    if expires_at.present? && expires_at <= Time.current
      errors.add(:expires_at, "must be in the future")
    end
  end
end
