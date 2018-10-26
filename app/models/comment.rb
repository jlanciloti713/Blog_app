class Comment < ApplicationRecord
    belongs_to :blog_post
    validates :blog_post, presence: true
    validates :username, presence: true, length: {minimum: 3, maximum: 20}
    validates :content, presence: true
end
