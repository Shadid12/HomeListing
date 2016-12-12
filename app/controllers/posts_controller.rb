class PostsController < ApplicationController
    
    before_action :authenticate_user!, :except => [:show, :index]
    

    def new
        @post = Post.new
    end
    
    def show
        @post = Post.find(params[:id])
    end
    
    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Hosting created!"
            redirect_to post_path(@post.id)
        else
            # TODO Create a Error Page
            redirect_to '/404.html'
        end
    end
    
    def index
        @posts = Post.all
    end
    
    def destroy
        @post = Post.find(params[:id])
        if @post.user == current_user
            if @post.destroy
                flash[:success] = "Posts Deleted!"
                redirect_to posts_path
            else
                render '/'
            end
        else
            redirect_to root_path
        end
    end
    
    private 
    
    def post_params
        params.require(:post).permit(:title, :description, :image)
    end
end
