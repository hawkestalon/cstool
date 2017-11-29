class Coach < ApplicationRecord
    validates :details, presence: true
    validates :goals, presence: true
    validates :reminder, presence: true
end
