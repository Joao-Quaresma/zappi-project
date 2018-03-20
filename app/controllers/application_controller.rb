class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  # Render 404 page when record not found
  def render_404      
    flash[:error] = "No record found"
    redirect_to root_path
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index]
  
  
  def index
  end
    

  
end
