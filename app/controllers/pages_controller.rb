class PagesController < ApplicationController

  def index
    @socialposts = Socialpost.order('created_at DESC')
    @articles = Article.order('created_at DESC')
    @announcements = Announcement.order('created_at DESC')
    @users = User.with_deleted.order('created_at DESC')
    @faqs = Faq.order('created_at DESC')
  end

  def contact
  end

  def about
  end
end
