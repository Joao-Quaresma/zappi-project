class BookmarksController < ApplicationController


  def index
    @user = User.with_deleted.find_by_username(params[:id])
    #@articles = @user.bookmarkees_by('Article').order(:position)
    #@articles = Article.all
    #@articles = Bookmark.order(:position)
    @bookmarked_articles = Bookmark.where(bookmarkee_type: 'Article', bookmarker_id: @user).order(:position)
    @articles = Article.all
  end

  def sort 
    params[:bookmark].each_with_index do |id, index|
        Bookmark.where(id: id).update_all(position: index + 1)
      end 
    head :ok
  end

  
end
