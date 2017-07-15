class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :find_post
  load_and_authorize_resource

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      render action: "new"
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully deleted.'
  end

  private
  
  def find_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:post_id, :body, :user_id)
  end
end
