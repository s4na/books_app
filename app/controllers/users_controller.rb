# frozen_string_literal: true

class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action only: [:show, :edit, :update, :destroy]

  # GET /resource
  # GET /resource.json
  def index
    @users = User.page(params[:page])
  end

  # # GET /resource/1
  # GET "users/:id"
  def show
    @user = User.find_by(id: params[:id])
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
