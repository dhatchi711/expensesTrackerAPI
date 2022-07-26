class ExpenseRepresenter
    def initialize(expenses)
        @expenses = expenses
    end

    def as_json
        expenses.map do |expense|
            {
                expenseOwner: expense.user.name,
                id: expense.id,
                expenseName: expense.expenseName,
                expenseCost: expense.cost
            }
        end
    end

    private 

    attr_reader :expenses
end