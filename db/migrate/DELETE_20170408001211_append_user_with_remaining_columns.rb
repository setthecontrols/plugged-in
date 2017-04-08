class AppendUserWithRemainingColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :location, :string
    add_column :users, :genre, :string
    add_column :users, :music_links, :text
    add_column :users, :band_status, :string
    add_column :users, :slogan, :string
    add_column :users, :bio, :text
    add_column :users, :experience, :text
    add_column :users, :instruments, :string
  end
end
