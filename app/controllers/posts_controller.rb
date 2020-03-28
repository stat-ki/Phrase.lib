class PostsController < ApplicationController

    before_action :ensure_correct_user, only: [:edit, :update, :destroy]

    def show
        @post = Post.find(params[:id])
        # When the post is not for share, only user posted this can access.
        if(@post.is_sharing == false)
            ensure_correct_user
        end
        unless(@post.is_original)
            @source = Source.find(@post.source_id)
        end
        if(@post.is_sharing)
            render("/posts/share_show")
        else
            render("/posts/note_show")
        end
    end

    def new

    end

    def create
        post = Post.new(
            user_id: current_user.id,
            phrase: params[:phrase],
            language: params[:language],
            detail: params[:detail],
            is_original: params[:is_original],
            is_sharing: params[:is_sharing]
        )
        unless(post.is_original)
            source = Source.find_by(
                category: params[:category],
                author: params[:author],
                title: params[:title]
            )
            # When no records matched, create as new record.
            if(source.blank?)
                source = Source.new(
                    category: params[:category],
                    author: params[:author],
                    title: params[:title]
                )
                source.save
            end
            post.source_id = source.id
        end
        post.save
        flash[:notice] = "投稿しました"
        redirect_to(post_path(post.id))
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        post.update(posts_params)
        flash[:notice] = "投稿を更新しました。"
        redirect_to(post_path(post.id))
    end

    def destroy
        post = Post.find(params[:id])
        was_shared = post.is_sharing
        post.destroy
        flash[:notice] = "投稿を削除しました。"
        if(was_shared)
            redirect_to(shares_path)
        else
            redirect_to(notes_path)
        end
    end

    def notes
        @posts = Post.where(user_id: current_user.id, is_sharing: false).order("created_at DESC")
    end

    def shares
        @posts = Post.where(is_sharing: true).order("created_at DESC")
    end

    def first_post

    end

    def translate
        post = Post.find(params[:id])
        # Create and encode URI parameter query.
        params = URI.encode_www_form(text: "\"#{post.phrase}\"", source: "en", target: "ja")
        # Parse URI to be enable to get host and port.
        uri = URI.parse(ENV["TRANSLATE_API_KEY"] + "?" + params)

        response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
            http.open_timeout = 5
            http.read_timeout = 10
            http.get(uri.request_uri)
        end

        begin
            if(response.is_a?(Net::HTTPRedirection))
                # Because response code will "302 Moved Temporarily", access the URI for redirct and request response again.
                response = Net::HTTP.get_response(URI.parse(response["location"]))
                # Convert response to JSON.
                result = JSON.parse(response.body)
                @text = result["text"]
            else
                raise
            end
        rescue => e
            flash[:notice] = "エラーが発生しました。時間をおいて再度お試しください。"
            redirect_to(post_path(post.id))
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

    private

    def posts_params
        params.require(:post).permit(:phrase, :language, :details, :is_original, :is_sharing)
    end

    def ensure_correct_user
        post = Post.find(params[:id])
        if(current_user != post.user)
            flash[:notice] = "権限がありません"
            redirect_to(user_path)
        end
    end

end
