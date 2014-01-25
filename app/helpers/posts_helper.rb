module PostsHelper
  def avatar_for_small(post)
    image_tag post.picture.url(:thumb) if post.picture?
  end
end
