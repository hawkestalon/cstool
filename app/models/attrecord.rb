class Attrecord < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :PTO, numericality: {greater_than_or_equal_to: 0}
  validates :FMLA, numericality: {greater_than_or_equal_to: 0}
  validates :days, numericality: {greater_than_or_equal_to: 0, less_than: 4}
end
