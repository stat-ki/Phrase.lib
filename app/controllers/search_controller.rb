class SearchController < ApplicationController
  def search_result
    case params[:search_model]
    when "user_name"
      @users = User.where("name LIKE?", "%#{params[:search_word]}%")
      return render("/search/user_index")
    when "phrase"
      @posts = Post.where("phrase LIKE?", "%#{params[:search_word]}%").where(is_sharing: true)
    when "source_title"
      sources = Source.where("title LIKE?", "%#{params[:search_word]}%")
    when "source_author"
      sources = Source.where("author LIKE?", "%#{params[:search_word]}%")
    end
    if sources.present?
      @posts = []
      sources.each do |source|
        matched_post = Post.where(source_id: source.id, is_sharing: true)
        @posts.push(matched_post)
      end
      # Convert 3D array to 2D array
      @posts.flatten!(2)
    end
    render("/search/posts_index")
  end

  def search_items
    post = Post.find(params[:id])
    source = Source.find(post.source_id)
    case source.category
    when "book"
      # books and magazines
      genreId = 200162
    when "movie"
      # DVDs
      genreId = 505034
    when "music"
      # CDs
      genreId = 101311
    else
      # All items
      genreId = 0
    end
    @items = RakutenWebService::Ichiba::Item.search(keyword: source.title, genreId: genreId).first(5)
  end
end
