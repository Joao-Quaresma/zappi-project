class FollowsFaqsController < FollowsController

  def followable
    @followable ||= Faq.find(params[:faq_id])
  end

end

