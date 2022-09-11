class UsersController < ApplicationController
    def index
        render json:User.all
    end

    def show
        user = User.find(params[:id])
        expenses = user.expenses
        render json: (expenses)
    end

    def create
        #user = User.create!(user_params)
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :balance, :username)
    end


end
