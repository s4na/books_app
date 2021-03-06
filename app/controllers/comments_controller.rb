# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: I18n.t(:Model_was_successfully_created, model: Comment.model_name.human) }
        format.json { render :show, status: :created, location: @commentable }
      else
        format.html { render :new }
        format.json { render json: @commentable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@commentable, @comment], notice: I18n.t(:Model_was_successfully_updated, model: Comment.model_name.human) }
        format.json { render :show, status: :ok, location: [@commentable, @comment] }
      else
        format.html { render :edit }
        format.json { render json: [@commentable, @comment].errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @commentable, notice: I18n.t(:Model_was_successfully_destroyed, model: Comment.model_name.human) }
      format.json { head :no_content }
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
      params.require(:comment).permit(:commentable, :name, :memo)
    end
end
