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

end
