class PostsController < ApplicationController
    before_filter :authenticate_user!, except: [:show, :index]
	#before_filter :find_user
	before_filter :find_post, only: [:show, :edit, :update, :destroy]
  def index
  	@posts = Post.paginate(page: params[:page])
  end

  def new
  	@post = current_user.posts.build
  end

  def create 
  	@post = current_user.posts.build(post_params)
  	if(@post.save)
  		flash[:success] = "you post has been successfully zapped(posted)"
  		redirect_to([@post])
  	else
  		flash[:error] = "post could not be created "
  		render 'new'
  	end
  end

  def show
    @comment = @post.comments.build
  end

  def edit

  end

  def update 
  	if @post.update_attributes(post_params)
  		flash[:success] = "you post has been successfully updated(edited) "
  		redirect_to([@post])
  	else
  		flash[:error] = "post could updated(edited)"
  		render 'edit'
  	end
  end

  def destroy 
  	@post.destroy 
  	flash[:success] = "post has been deleted"
  end
#--------------------private-----------------------
  def post_params
  	prms = params.require(:post).permit!
  	prms.merge!(user: current_user)
  end
  # def find_user
  # 	@user = User.find(params[:user_id])
  # end
   def find_post
   	@post = Post.find(params[:id])
   end
end
