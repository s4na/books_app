class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])

    p "comment_params" # debug
    pp comment_params # debug
    p "@book.comments" # debug
    pp @book.comments # debug

    @book.comments.create(comment_params)
    redirect_to book_path(@book)
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :memo)
    end
end
