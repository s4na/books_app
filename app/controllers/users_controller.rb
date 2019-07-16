# frozen_string_literal: true

class UsersController < ApplicationController
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
end
