class RemoveTagIdFromBlogPosts < ActiveRecord::Migration[5.2]
  def change
  remove_column :blog_posts, :tag_id, :string
  end
end
