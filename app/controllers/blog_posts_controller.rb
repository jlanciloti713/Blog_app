class BlogPostsController < ApplicationController
    def index

        if params[:tag]
            @tag_name = params[:tag]
            @tag = Tag.where('name LIKE ?', "%#{@tag_name}%")[0]

            if @tag != nil
                @blog_posts = @tag.blog_posts
            else
                @blog_posts = []
            end
        else
          @blog_posts = BlogPost.all
        end
    
    end



        # @tag_name = params[:tag]
        # if Tag.find_by(name: @tag_name)
        #     @blog_posts = Tag.find_by(name: @tag_name).blog_posts
        # else
        #     @blog_posts = BlogPost.all
        # end
    # end

    def show
        id = params[:id]
        @blog_post = BlogPost.find(id)
    end

    def new
        @tags= Tag.all
    end

    def create

        @blog_post = BlogPost.create(title: params[:title], content: params[:content])
        params[:tag_ids].each do |tag_id|
            BlogPostTag.create(
                                blog_post_id: @blog_post.id, 
                                tag_id: tag_id
                                )
        end 
        redirect_to ("/blog_posts")
    end

    def edit
        id = params[:id]
        @blog_post = BlogPost.find(id)  
        @tags=Tag.all

    end

    def update

        @blog_post = BlogPost.find(params[:id])
        @blog_post.update(

                title: params[:title],
                content: params[:content]
            )
        submitted_tag_ids = params[:tag_ids].map { |tag_id| tag_id.to_i }
        old_tag_ids = @blog_post.tag_ids - submitted_tag_ids
        new_tag_ids = submitted_tag_ids - @blog_post.tag_ids

        old_tag_ids.each do |tag_id|
            BlogPostTag.find_by(blog_post_id: @blog_post.id, tag_id: tag_id).destroy
        end
        new_tag_ids.each do |tag_id|
            BlogPostTag.find_by(blog_post_id: @blog_post.id, tag_id: tag_id)
        end

        redirect_to ("/blog_posts/#{@blog_post.id}")

    end
      
    def destroy

        @blog_post = BlogPost.find(params[:id])
        @blog_post.destroy
        redirect_to("/blog_posts")
          
    end  
end
