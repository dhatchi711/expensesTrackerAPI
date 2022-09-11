class ExpensesController < ApplicationController
    include ActionController::HttpAuthentication::Token
    before_action :authenticate_user, only: [:create, :destroy]

    def index
        expenses = Expense.all
        render json: ExpenseRepresenter.new(expenses).as_json
    end

    def create
        user = User.find(user_params[:userId])
        if expense_params[:cost] < user.balance
            user.update_column(:balance, (user.balance - expense_params[:cost]))
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
    def authenticate_user
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        User.find(user_id)
    rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
    end

    def user_params
        params.require(:user).permit(:userId)
    end
    def expense_params
        params.require(:expense).permit(:expenseName, :cost)
    end
end
