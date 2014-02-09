class CreateRelashionships < ActiveRecord::Migration
  def change
    create_table :relashionships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relashionships, :follower_id
    add_index :relashionships, :followed_id
    add_index :relashionships, [:follower_id, :followed_id], unique: true 
  end
end
