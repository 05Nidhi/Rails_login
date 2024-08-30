class AccountsController < ApplicationController
  # before_action :authorize_request, except: :login
	def create
		user = Account.new(account_params)
		if user.save
			render json: user, status: :created
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end

	def login
		user = Account.find_by(email: params[:account][:email])
		if user&.authenticate(params[:account][:password])
			token = JsonWebToken.encode(user_id: user.id)
			render json: { token: token, user: user }, status: :ok
		else
			
		render json: { error: "Invalid email or password" }, status: :unauthorized
		end
	end

	private

	def account_params 
		params.require(:account).permit(:first_name, :last_name, :email, :password) 
	end

end
