class RelashionshipsController < ApplicationController
	#before_filter :signed_in_user

	def create 
		@user = User.find(params[:relashionship][:followed_id])
		current_user.follow!(@user)
		redirect_to [:everyone, @user]
	end
	def destroy 
		@user = Relashionship.find(params[:id]).followed
		current_user.unfollow!(@user)
		redirect_to [:everyone, @user]
	end
end