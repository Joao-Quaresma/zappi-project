class FollowsCategoriesController < FollowsController

  def followable
    @followable ||= Category.find(params[:category_id])
  end

end