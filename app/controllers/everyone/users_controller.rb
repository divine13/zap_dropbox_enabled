class Everyone::UsersController < ApplicationController
    before_filter :authenticate_user!, except: [:show]
	before_filter :find_user, only: [:show, :edit, :update]
  before_filter :correct_user, only: [:update, :edit]
  def index
  	@users = User.all
  end

  def show

  end

  def edit
  end

  def update 
  	set_admin
  	if @user.update_attributes(user_params)
  		flash[:success] = "user information has been updated"
  		redirect_to everyone_user_path(current_user)
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

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.all
    render 'show_follow'
  end
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.all   #paginate(page: params[:page])
    render 'show_follow'
end

#-------------------private--------------------
private 

  def user_params
  params.require(:user).permit(:email, :password, :password_confirmation, :admin, :admin, :status, :intrests, :bio, :age, :picture)
  end
  def find_user
  	@user = User.find(params[:id])
  end
  def set_admin
  	@user.admin = user_params[:admin] == '1'
  end

  def correct_user 
  @user = User.find(params[:id])
  redirect_to root_path, notice: "what are you doing, lebo!, i have caught a hacker here "  if current_user != @user
  end
end
