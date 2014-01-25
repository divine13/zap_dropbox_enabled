class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :designer
      t.text :about
      t.string :contact_details
      t.references :user, index: true

      t.timestamps
    end
  end
end
