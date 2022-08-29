class ExpenseRepresenter
    def initialize(expenses)
        @expenses = expenses
    end

    def as_json
        expenses.map do |expense|
            {
                id: expense.id,
                expenseOwnerID: expense.user.id,
                expenseOwnerName: expense.user.name,
                expenseName: expense.expenseName,
                expenseCost: expense.cost
            }
        end
    end

    private 

    attr_reader :expenses
end