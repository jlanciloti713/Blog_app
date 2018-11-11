class CommentsController < ApplicationController
    
    def index
        redirect_back(fallback_location: "/blog_posts")
    end

    def create
        @new_comment = Comment.new(

                                    content: params[:content],
                                    blog_post_id: params[:blog_post_id],
                                    user_id: current_user.id
                                )

        respond_to do |format|
            if @new_comment.save
                format.html {redirect_to "/blog_posts/#{@new_comment.blog_post_id}"}
                format.json {render json: @new_comment, include: :user, status: 200}
            else
                format.html do
                @blog_post = BlogPost.find(params[:blog_post_id])
                render '/blog_posts/show'
                end
                format.json {render json: {errors: @new_comment.errors.full_messages}, status: 400}
            end
        end
    end

    def destroy
        blog_post_id = Comment.find(params[:id]).blog_post_id
        Comment.find(params[:id]).destroy
        redirect_to "/blog_posts/#{blog_post_id}"
    end
end

