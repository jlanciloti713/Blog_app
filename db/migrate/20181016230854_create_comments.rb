class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :username
      t.text :content
      t.integer :blog_post_id

      t.timestamps
    end
  end
end
