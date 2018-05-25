class BookmarksController < ApplicationController


  def index
    @user = User.with_deleted.find_by_username(params[:id])

    @bookmarked_articles = Bookmark.where(bookmarkee_type: 'Article', bookmarker_id: @user).order(:position)
    @articles = Article.all

    @bookmarked_announcements = Bookmark.where(bookmarkee_type: 'Announcement', bookmarker_id: @user).order(:position)
    @announcements = Announcement.all

    @bookmarked_faqs = Bookmark.where(bookmarkee_type: 'Faq', bookmarker_id: @user).order(:position)
    @faqs = Faq.all

  end

  def sort 
    params[:bookmark].each_with_index do |id, index|
        Bookmark.where(id: id).update_all(position: index + 1)
      end 
    head :ok
  end

  
end
