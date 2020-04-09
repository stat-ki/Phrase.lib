class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id)
    @posts = []
    error_count = 0
    favorites.each do |favorite|
      begin
        post = Post.find(favorite.post_id)
      # When the post isn't fond (ex.deleted), reise error.
      rescue ActiveRecord::RecordNotFound
        error_count += 1
        next
      end
      @posts.push(post)
    end
    unless error_count == 0
      flash.now[:notice] = "#{error_count}件の投稿が削除されていたため、取得できませんでした。"
    end
  end

  def create
    post = Post.find(params[:post_id])
    favorite = Favorite.new(
      user_id: current_user.id,
      post_id: post.id
    )
    favorite.save
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = Favorite.find_by(
      user_id: current_user.id,
      post_id: post.id
    )
    favorite.destroy
  end
end
