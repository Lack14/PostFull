class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post,only: [:show,:edit,:update,:destroy,:upvote]
  def index
    @posts = Post.all.order("created_at DESC").paginate(page: params[:page],per_page: 10)
  end

  def show
    @bookmark = Bookmark.new
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.new
    
  end
  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.html{redirect_to @post, notice: "Tu foto se ha subido"}
        format.json{head :no_content}
      else
        format.html{render "new", notice: "Problemas al subir Tu foto"}
        format.json{head :no_content}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
          format.html{redirect_to @post, notice: "Tu foto se ha actualizado"}
        format.json{head :no_content}
      else
        format.html{render "edit", notice: "Problemas al editar tu foto"}
        format.json{head :no_content}
      end
    end
  end
  def destroy
    @post.destroy
    respond_to do |format|
      format.html{redirect_to @post, notice: "Tu foto se ha eliminado"}
        format.json{head :no_content}
    end
  end
  def upvote
    @post.upvote_by current_user
    redirect_to @post
  end
  private
  def find_post
    @post = Post.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:titl,:body,:image)
  end
end
