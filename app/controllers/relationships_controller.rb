# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)

    flash[:success] = "You have start following #{@user.username.capitalize}."
    redirect_to users_path
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)

    flash[:notice] = "You have stop following #{@user.username.capitalize}."
    redirect_to users_path
  end
end
