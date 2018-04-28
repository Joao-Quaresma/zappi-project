class FollowsArticlesController < FollowsController

  def followable
    @followable ||= Article.find(params[:article_id])
  end

end


