class SearchController < ApplicationController

    def search_result
        case(params[:search_model])
        when("user_name")
            @users = User.where("name LIKE?", "%#{params[:search_word]}%")
            render("/search/user_index")
        when("phrase")
            @posts = Post.where("phrase LIKE?", "%#{params[:search_word]}%").where(is_sharing: true)
            render("/search/posts_index")
        end
    end

    def search_items
        post = Post.find(params[:id])
        source = Source.find(post.source_id)
        case source.category
        # book
        when 0
            @genreId = 200162
        # movie
        when 1
            @genreId = 505034
        # music
        when 2
            @genreId = 101311
        end
        @items = RakutenWebService::Ichiba::Item.search(keyword: source.title, genreId: @genreId).first(5)
    end

end
