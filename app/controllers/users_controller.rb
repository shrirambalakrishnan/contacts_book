class UsersController < ApplicationController
	def new
		@user=User.new
	end

	def create
		@user=User.create(user_params)
		if @user.save
			redirect_to @user
		else
			render 'new'
		end
	end

	def user_params
		params.require(:user).permit(:username,:password,:password_confirmation,:email)
	end

	def show
		@user=User.find(params[:id])
	end

	def index
		@users=User.all
	end
end
