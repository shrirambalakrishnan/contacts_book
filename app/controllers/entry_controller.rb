class EntryController < ApplicationController
	def new
	end

	def check
		@user=User.find_by(username: params[:user][:username], password: params[:user][:password])
	  	if @user
	  		session[:id]=@user.id
	  		#byebug
	  		redirect_to controller: "contacts", action: "index"
	  	else
	  		render 'new'
	  	end
	end
end
