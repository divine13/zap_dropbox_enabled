class Admin::PermissionsController < Admin::BaseController
  before_filter :find_user
	def index 
		@ability = Ability.new(@user)
		@users = User.all
	end
	def update 
		@user.permissions.clear
		update_params.each do |id, permissions|
			user = User.find(id)
			permissions.each do |permission, checked|
				permission.create(user: @user, thing: user, action: permission)
			end
		end
		flash[:notice] = "user permissions have been updated"
		redirect_to admin_user_permissions_path
	end
#-------------private--------------
	def find_user
		@user = User.find(params[:user_id])
	end
	def update_params
		params.require(:permissions).permit!
	end
end
