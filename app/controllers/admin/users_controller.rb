class Admin::UsersController < Admin::BaseController
	before_filter :find_user, only: [:show, :edit, :update, :destroy]

  def index
  	@users = User.all
  end
def create 
   @user = User.new(user_params)
   set_admin
  if @user.save
   flash[:success] = "#{current_user} has created a user via admin dashboard"
  redirect_to admin_users_path
   else
   flash[:error] = "error user could not be created "
   render 'new'
 end
end

  def new
  	@user = User.new
  end

  def show

  end

  def edit
  end

  def update 
  	set_admin
  	if @user.update_attributes(user_params)
  		flash[:success] = "user information has been updated"
  		redirect_to admin_users_path
  	else
  		flash[:error] = "user information could not be updated"
  		render :edit
  	end
  end 

  def destroy 
  	if @user == current_user
  		flash[:notice] = "you can't delete your self"
  	else 
  		@user.destroy
  		flash[:success] = "user has been eliminated (deleted in other word)"
  		redirect_to admin_user_path
    end
  end
#-------------------private--------------------
private 

  def user_params
  params.require(:user).permit(:email, :password, :password_confirmation)
  end
  def find_user
  	@user = User.find(params[:id])
  end
  def set_admin
  	@user.admin = user_params[:admin] == '1'
  end
end
