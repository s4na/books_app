# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :set_user

  def create
    @user = User.find(params[:follow][:follow_id])
    following = current_user.follow(@user)
    following.save

    respond_to  do |format|
      format.html { redirect_to @user, notice: I18n.t(:Model_was_successfully_created, model: Follow.model_name.human) }
    end
  end

  def destroy
    @user = User.find(params[:follow][:follow_id])
    following = current_user.unfollow(@user)
    following.destroy

    respond_to  do |format|
      format.html { redirect_to @user, notice: I18n.t(:Model_was_successfully_destroyed, model: Follow.model_name.human) }
    end
  end

  private
    def set_user
      @user = User.find(params[:follow][:follow_id])
    end
end
