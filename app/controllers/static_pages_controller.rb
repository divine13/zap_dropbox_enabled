class StaticPagesController < ApplicationController
  def index
    @post = Post.paginate(page: params[:page])
  end

  def about
  end

  def contact_us
  end
end
