class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy, :notes]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    unless @post.is_original
      @source = Source.find(@post.source_id)
    end
    if @post.is_sharing
      render("/posts/share_show")
    else
      # When the post is not for share, only user posted this can access.
      ensure_correct_user
      render("/posts/note_show")
    end
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "投稿が見つかりません"
    redirect_back(fallback_location: root_path)
  end

  def new
    @post = Post.new
    @source = Source.new
  end

  def create
    @post = Post.new(posts_params)
    @post.user_id = current_user.id
    unless @post.is_original
      params[:post][:source][:user_id] = current_user.id
      # When no records matched, create as new record.
      @source = Source.find_or_create_by(sources_params)
      if @source.invalid?
        flash[:notice] = "出典に項目の不備があります"
        return render("/posts/new")
      end
      @post.source_id = @source.id
    end
    if @post.valid?
      @post.save
      flash[:notice] = "投稿しました"
      redirect_to(post_path(@post.id))
    else
      flash[:notice] = "未入力の項目か入力内容に不備があります"
      return render("/posts/new")
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.is_original
      # When the post has source (not original), define source to enable to be edited.
      @source = Source.find(@post.source_id)
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(posts_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to(post_path(post.id))
    else
      flash[:notice] = "未入力の項目か入力内容に不備があります"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to(user_path(current_user.id))
  end

  def notes
    @posts = Post.where(user_id: current_user.id, is_sharing: false).order("created_at DESC")
  end

  def shares
    @posts = Post.includes(:user).where(is_sharing: true).order("created_at DESC")
  end

  def first_post
    @post = Post.new
    @source = Source.new
  end

  def translate
    post = Post.find(params[:id])
    # Create and encode URI parameter query.
    params = URI.encode_www_form(text: "\"#{post.phrase}\"", source: post.language, target: "ja")
    # Parse URI to be enable to get host and port.
    uri = URI.parse(ENV["TRANSLATE_API_KEY"] + "?" + params)

    begin
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.open_timeout = 5
        http.read_timeout = 10
        http.get(uri.request_uri)
      end

      if response.is_a?(Net::HTTPRedirection)
        # Because response code will "302 Moved Temporarily", access the URI for redirect and request response again.
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

  private

  def posts_params
    params.require(:post).permit(:phrase, :language, :details, :is_original, :is_sharing)
  end

  def sources_params
    params.require(:post).require(:source).permit(:category, :author, :title, :user_id)
  end

  def ensure_correct_user
    post = Post.find(params[:id])
    if current_user != post.user
      flash[:notice] = "権限がありません"
      redirect_to(user_path(current_user.id))
    end
  end
end
