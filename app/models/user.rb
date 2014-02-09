class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_attached_file :picture, :styles => { :medium => "225x225>", :thumb => "100x100>" },
                           :default_url => ":rails_root/images/:style/profile.jpg"

         has_many :posts
         has_many :relashionships, foreign_key: "follower_id", dependent: :destroy
         has_many :followed_users, through: :relashionships, source: :followed


          has_many :reverse_relashionships, foreign_key: "followed_id",
                                                  class_name: "Relashionship",
                                                  dependent: :destroy

          has_many :followers, through: :reverse_relashionships, source: :follower


         has_many :permissions

         def to_s
         	"#{email} (#{admin? ? "Admin" : "User"})"
         end

         def following?(other_user)
          relashionships.find_by_followed_id(other_user.id)
         end

         def follow!(other_user)
          relashionships.create!(followed_id: other_user.id)
         end

         def unfollow!(other_user)
          relashionships.find_by_followed_id(other_user.id).destroy
         end
end
