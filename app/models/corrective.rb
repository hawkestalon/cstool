class Corrective < ApplicationRecord
  validates :description, presence: true
  validates :plan, presence: true
  validates :action, presence: true
  belongs_to :user
end
