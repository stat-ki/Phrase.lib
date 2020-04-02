class SourcesController < ApplicationController

    before_action :authenticate_user!, only: [:update]
    before_action :ensure_correct_user, only: [:update]

    def show
        source = Source.find(params[:id])
        @posts = []
        # Conditional expression must be writtened, because query parameter is string class.
        if(params[:title_search] == "true")
            sources = Source.where(title: source.title)
        else
            sources = Source.where(author: source.author)
        end
        sources.each do |source|
            matched_post = Post.where(source_id: source.id, is_sharing: true)
            @posts.push(matched_post)
        end
        # Convert 3D array to 2D array
        @posts.flatten!(2)
    end

    def update
        source = Source.find(params[:id])
        source.update(sources_params)
        flash[:notice] = "出典を更新しました"
        redirect_to(user_path(current_user.id))
    end

    private

    def sources_params
        params.require(:source).permit(:category, :author, :title)
    end

    def ensure_correct_user
        source = Source.find(params[:id])
        if(source.user_id != current_user.id)
            flash[:notice] = "権限がありません"
            redirect_to(user_path(current_user.id))
        end
    end
end
