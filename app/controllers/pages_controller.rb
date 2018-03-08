class PagesController < ApplicationController
  def index
    @socialposts = Socialpost.order('created_at DESC')
  end

  def contact
  end

  def about
  end
end
