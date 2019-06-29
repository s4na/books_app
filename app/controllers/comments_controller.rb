# frozen_string_literal: true

class CommentsController < ApplicationController

  before_action :set_commentable
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def show
  end

  def create
    @comment = @commentable.comments.new(comment_params)

    if @comment.save
      redirect_to [@commentable, @comment]
    else
      render :new
    end
  end

  private
    def set_commentable
      resource, id = request.path.split("/")[1, 2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:name, :memo)
    end
end
