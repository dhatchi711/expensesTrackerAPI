class ExpensesController < ApplicationController
    def index
        expenses = Expense.all
        render json: ExpenseRepresenter.new(expenses).as_json
    end

    def create
        user = User.create!(user_params)
        expense = Expense.new(expense_params.merge(user_id: user.id))
        if expense.save
            render json: expense
        else
            render json: expense.errors
        end
    end

    def destroy
        Expense.find(params[:id]).destroy!
    end
    private
    def user_params
        params.require(:user).permit(:name, :balance)
    end
    def expense_params
        params.require(:expense).permit(:expenseName, :cost)
    end
end
