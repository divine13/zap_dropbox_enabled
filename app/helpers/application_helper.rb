module ApplicationHelper
	
	def full_title(title)
		base_name = "Zap"
		if(title.empty?)
			base_name
		else
			"#{base_name} :: #{title}"
		end
	end

	def admins_only(&block)
		block.call if current_user.try(:admin?)
		nil
	end
	def auth_admin(permission, thing, &block)
		block.call if(can?(permission.to_sym, thing)) ||
		current_user.try(:admin?)
		nil
	end

	 def avatar_for_small(post)
         if post.picture?
          image_tag post.picture.url(:thumb)
         else 
          image_tag "thumb/profile.jpg"
         end
     end

     def avatar_for(post)
     	if post.picture?
     	image_tag post.picture.url(:medium)
     	else
     		image_tag "medium/profile.jpg"
     	end 
     end
end