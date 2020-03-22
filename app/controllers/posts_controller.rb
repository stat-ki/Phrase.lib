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
        post = Post.update(post_params)
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

    private

    def posts_params
        params(:posts).permit(:phrase, :language, :details, :is_original, :is_sharing)
    end

    def ensure_correct_user
        post = Post.find(params[:id])
        if(current_user != post.user)
            flash[:notice] = "権限がありません"
            redirect_to(user_path)
        end
    end

end
