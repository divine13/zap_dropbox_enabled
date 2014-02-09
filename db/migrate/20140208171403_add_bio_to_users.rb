class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string
    add_column :users, :intrests, :string
    add_column :users, :age, :integer
    add_column :users, :bio, :text
  end
end
