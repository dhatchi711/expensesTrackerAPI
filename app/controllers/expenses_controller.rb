class ExpensesController < ApplicationController
    def index
        expenses = Expense.all
        render json: ExpenseRepresenter.new(expenses).as_json
    end

    def create
        #user = User.create!(user_params)
        user = User.find(user_params[:userId])
        if expense_params[:cost] < user.balance
            remainderBalanceAfterExpense = user.balance - expense_params[:cost]
            user.update_column(:balance, remainderBalanceAfterExpense)
            expense = Expense.new(expense_params.merge(user_id: user.id))
            if expense.save
                render json: expense
            end
        else
            render json: user.errors
        end
    end

    def destroy
        Expense.find(params[:id]).destroy!
    end
    private
    def user_params
        params.require(:user).permit(:userId)
    end
    def expense_params
        params.require(:expense).permit(:expenseName, :cost)
    end
end
