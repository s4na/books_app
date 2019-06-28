class CommentsController < ApplicationController
  def create
    unless params[:book_id].nil?
      p "params[:book_id] = not nil" # debug
      @book = Book.find(params[:book_id])
      @book.comments.create(comment_params)
      redirect_to book_path(@book)
    end

    unless params[:report_id].nil?
      p "params[:report_id] = not nil" # debug
      @report = Report.find(params[:report_id])
      @report.comments.create(comment_params)
      redirect_to report_path(@report)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :memo)
    end
end
