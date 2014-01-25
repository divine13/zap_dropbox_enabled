class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def auth_admin 
  	authenticate_user!
  	unless current_user.admin? 
  		flash[:error] = "You cant perform this action because you are not an admin"
  		redirect_to(root_path)
  	end
  end
end
