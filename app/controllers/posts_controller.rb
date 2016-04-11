class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  # GET /reviews/1/posts
  def index
    #find the review for the id provided
    @review = Review.find(params[:review_id])
    @posts = @review.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @review = Review.find(params[:review_id])
    @post = @review.posts.find(params[:id])
  end

  # GET /posts/new
  # GET /reviews/1/posts/new
  def new
    @review = Review.find(params[:review_id])
    @post = @review.posts.build
  end

  # GET /posts/1/edit
  def edit
    @review = Review.find(params[:review_id])
    @post = @review.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @review = Review.find(params[:review_id])
    @post = @review.posts.build(post_params)

      if @post.save
        redirect_to review_post_url(@review, @post)
      else
        render :action => "new"
      end
  end


  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @review = Review.find(params[:review_id])
    @post = Post.find(params[:id])
      if @post.update_attributes(post_params)
        redirect_to review_post_url(@review, @post)
      else
        render :action =>"edit"
      end
    
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @review = Review.find(params[:review_id])
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to review_posts_path(@review) }
      format.xml { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:post_message)
    end
end
