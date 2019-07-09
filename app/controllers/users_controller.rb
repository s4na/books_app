# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /resource
  # GET /resource.json
  def index
    # @books = Book.page(params[:page]).per(5)
    @users = User.page(params[:page]).per(5)
  end

  # # GET /resource/1
  # GET "users/:id"
  def show
    p "UsersController#show"
    @user = User.find(params[:id])
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
