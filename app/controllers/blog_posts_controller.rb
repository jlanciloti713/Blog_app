class BlogPostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

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
        @new_comment = Comment.new
    end

    def new
        @blog_post = BlogPost.new
        @tags= Tag.all
    end

    def create

        @blog_post = BlogPost.new(title: params[:title], content: params[:content], user_id: current_user.id)

        if @blog_post.save
            @blog_post.create_tags(params[:tag_ids]) if params[:tag_ids]
            flash[:success] = "Good Job! You made a blog post"
            redirect_to ("/blog_posts")
        else
            @tags= Tag.all
            render 'new'
        end

    end

    def edit
        id = params[:id]
        @blog_post = BlogPost.find(id)  
        @tags=Tag.all

    end

    def update

        @blog_post = BlogPost.find(params[:id])
        

        if @blog_post.update(title: params[:title], content: params[:content])
            @blog_post.update_tags(params[:tag_ids])if params[:tag_ids]
                # submitted_tag_ids = params[:tag_ids].map { |tag_id| tag_id.to_i }
                # old_tag_ids = @blog_post.tag_ids - submitted_tag_ids
                # new_tag_ids = submitted_tag_ids - @blog_post.tag_ids

                # old_tag_ids.each do |tag_id|
                #     BlogPostTag.find_by(blog_post_id: @blog_post.id, tag_id: tag_id).destroy
                # end
                # new_tag_ids.each do |tag_id|
                #     BlogPostTag.find_by(blog_post_id: @blog_post.id, tag_id: tag_id)
                # end
            # end 

            redirect_to ("/blog_posts/#{@blog_post.id}")
        else 
            @tags = Tag.all
            render 'edit'
        end

    end
      
    def destroy

        @blog_post = BlogPost.find(params[:id])
        @blog_post.destroy
        redirect_to("/blog_posts")
          
    end  
end
