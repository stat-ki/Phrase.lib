class SourcesController < ApplicationController

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
        flash[:notice] = "出典を更新しました。"
        redirct_to(user_path(current_user.id))
    end

    private

    def sources_params
        params.require(:source).permit(:category, :author, :title)
    end

end
