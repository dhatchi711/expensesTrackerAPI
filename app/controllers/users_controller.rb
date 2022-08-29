class UsersController < ApplicationController
    def index
        render json:User.all
    end

    def show
        user = User.find(params[:id])
        expenses = user.expenses
        render json: (expenses)
    end

end
