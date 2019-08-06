# frozen_string_literal: true

class FollowingsController < ApplicationController
  before_action :set_user
  PER_COUNT_USERS = 3

  def show
    @users = @user.followings.page(params[:page]).per(PER_COUNT_USERS)
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end
end
