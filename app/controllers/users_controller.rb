class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.includes(:user).where(user_id: @user.id, is_sharing: true)
  end
end
