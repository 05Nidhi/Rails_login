class AccountsController < ApplicationController
	def create
		user = Account.new(account_params)
		if user.save
			render json: user, status: :ok
		else
			render json: user.errors, status: :unprocessable_entity
		end
	end

	private

	def account_params 
		params.require(:account).permit(:first_name, :last_name, :email, :password) 
	end

end
