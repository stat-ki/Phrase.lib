class FavoritesController < ApplicationController

    def create
        @post = Post.find(params[:post_id])
        favorite = Favorite.new(
            user_id: current_user.id,
            post_id: @post.id
        )
        favorite.save
    end

    def destroy
        @post = Post.find(params[:post_id])
        favorite = Favorite.find_by(
            user_id: current_user.id,
            post_id: @post.id
        )
        favorite.destroy
    end

end
