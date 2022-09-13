class UsersController < ApplicationController
    include ActionController::HttpAuthentication::Token
    before_action :authenticate_user, only: [:show]

    def index
        render json:User.all
    end

    def show
        userId = params[:id].to_i
        #user = @currUser
        if userId != @user_id
            render json: {error: "Unauthorized to view user's expenses."}, status: :unprocessable_entity
        else
            user = User.find(userId)
            expenses = user.expenses
            render json: (expenses)
        end
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

    private
    def authenticate_user
        token, _options = token_and_options(request)
        @user_id = AuthenticationTokenService.decode(token)
        #@currUser = User.find(user_id)
    rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
    end

    def user_params
        params.require(:user).permit(:name, :balance, :username, :password)
    end
end
