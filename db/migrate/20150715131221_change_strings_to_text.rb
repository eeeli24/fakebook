class ChangeStringsToText < ActiveRecord::Migration
  def change
    change_column :posts, :body, :text
    change_column :comments, :body, :text
  end
end
