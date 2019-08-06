# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :set_user
  PER_COUNT_USERS = 3

  def show
    @users = @user.followers.page(params[:page]).per(PER_COUNT_USERS)
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end
end
