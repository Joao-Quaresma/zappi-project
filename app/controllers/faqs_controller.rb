class FaqsController < ApplicationController
    before_action :set_faq, only: [:edit, :update, :show, :destroy, :require_same_user]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    after_action :notified_users, only: [:create, :update]
  
  def index
    @faqs = Faq.all.order("updated_at DESC").paginate(page: params[:page], per_page: 21)
  end
  
 
  def new
    @faq = Faq.new
  end
  
  def edit
  end
  
  
    def create
        @faq = Faq.new(faq_params)
        @faq.user = current_user
        if @faq.save
          if @faq.categories.any? do |category|
              create_notification @faq, category
            end
          end
          flash[:success] = "Faq was successfully created"
          redirect_to faq_path(@faq)
        else
          render 'new'
        end
    end
  
  
  def update
    if @faq.update(faq_params)
      flash[:success] = "Faq was successfully updated"
      redirect_to faq_path(@faq)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @faq.destroy
    flash[:danger] = "Faq was successfully deleted"
    redirect_to faqs_path
  end
  
  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @faq = Faq.search(params[:search_param])
      flash.now[:danger] = "No faq match this search criteria" if @faq.blank?
    end
    render partial: 'faqs/result'
  end
  
  
  def mentions
    @mentions ||= begin
                    regex = /@([\w]+)/
                    @faq.description.scan(regex).flatten
                    @faq.body.scan(regex).flatten
                  end
  end
  
  def mentioned_users
    @mentioned_users ||= User.where(username: mentions)
  end

  def notified_users
      mentioned_users.each do |user|
        Mail.new(user)
          return if user.id == current_user.id 
          Faqnotification.create(user_id: user.id,
                      notified_by_id: current_user.id,
                      faq_id: @faq.id,
                        identifier: @faq.id,
                      notice_type: 'tagged')
      end
  end
  
  
  
  private
    def set_faq
      @faq = Faq.find(params[:id])
    end
    
    def faq_params
    params.require(:faq).permit(:title, :description, :body, category_ids: [])
    end

    def require_same_user
      unless current_user == @faq.user || current_user.admin?
        flash[:danger] = "You can only delete your Faq's"
        redirect_to faqs_path
      end
    end

    def create_notification(faq, category)
      @users = User.all.where("id != ?", current_user.id)
      @users.each do |user|
        if user.following?(category)
          Faqnotification.create(user_id: user.id,
                            notified_by_id: current_user.id,
                            faq_id: @faq.id,
                            identifier: @faq.id,
                            notice_type: 'New FAQ')
        end
      end
    end
  
end

