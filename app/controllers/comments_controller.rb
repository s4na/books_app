# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    unless params[:book_id].nil?
      book = Book.find(params[:book_id])
      commentable.create(comment_params)
      comment = book.comments.new(comment_params)
      comment.save!

      redirect_to book_path(book)
    end

    unless params[:report_id].nil?
      report = Report.find(params[:report_id])
      comment = report.comments.new(comment_params)
      comment.save!

      redirect_to report_path(report)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :memo)
    end
end
