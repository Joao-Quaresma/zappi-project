class SocialpostsController < ApplicationController
    
    
  def index
      
  end
  
  def new
      @socialpost = Socialpost.new
  end  
  
end