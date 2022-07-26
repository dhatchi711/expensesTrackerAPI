class Expense < ApplicationRecord
    validates :expenseName, presence: true, length: {minimum: 3}
    belongs_to :user
end
