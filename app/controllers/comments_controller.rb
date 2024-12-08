class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to product_path(@product), notice: "Comment posted successfully."
    else
      redirect_to product_path(@product), alert: "Failed to post comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit( :body)
  end
end
