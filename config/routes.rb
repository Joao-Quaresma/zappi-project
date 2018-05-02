Rails.application.routes.draw do

  resources :faqnotifications
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  
  get 'zappisocial', to: 'pages#index'
 
 #notification routes for socialposts
  get 'notifications/link_through'
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications', to: 'notifications#index'
  get 'notifications_all_read', to: 'notifications#index_all_read'
  resources :notifications do
    post :read_all, on: :collection
  end
 
  get 'users', to: "users#index", as: "users"
  get 'users/:id', to: "users#show", as: "user"
  patch 'users/edit', to: 'users#update', as: :update_user
  resources :users
  get 'user_search_results', to: "users#search"
  get 'user/:id/user_socialposts_search', to: "users#user_socialposts_search", as: "user_socialposts_search"
  get 'user/:id/user_articles_search', to: "users#user_articles_search", as: "user_articles_search"
  get 'user/:id/user_faqs_search', to: "users#user_faqs_search", as: "user_faqs_search"
  get 'user/:id/user_announcements_search', to: "users#user_announcements_search", as: "user_announcements_search"
  get 'deleted_users_index', to: "users#deleted_users_index"
  get 'user/:id/to_do_list', to: "users#to_do_list", as: "to_do_list"
  get 'user/:id/user_follow_articles', to: "users#user_follow_articles", as: "user_follow_articles"
  get 'user/:id/user_follow_announcements', to: "users#user_follow_announcements", as: "user_follow_announcements"
  get 'user/:id/user_follow_faqs', to: "users#user_follow_faqs", as: "user_follow_faqs"
  
  root to: 'pages#index'
  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'
  
  #zappisocial routes
  resources :socialposts do
    resources :comments
    member do
      get 'like'
      get 'unlike'
    end
  end
  get 'socialpost_search', to: "socialposts#socialpost_search"
  get 'socialpost_search_results', to: "socialposts#search"
  
  resources :articles do
    collection do
      patch :sort
    end
    resources :follows, :controller => 'follows_articles', :only => [:create, :destroy]
    resources :article_comments
  end
  post 'articles/:id/create_article_bookmark', to: "articles#create_article_bookmark", as: "create_article_bookmark"
  post 'articles/:id/destroy_article_bookmark', to: "articles#destroy_article_bookmark", as: "destroy_article_bookmark"
  get 'wiki_search', to: "articles#wiki_search"
  get 'wiki_search_results', to: "articles#search"
  get 'user/:id/articles_bookmark_list', to: "articles#articles_bookmark_list", as: "articles_bookmark_list"
  get 'articlenotifications/link_articlethrough'
  get 'articlenotifications/:id/link_articlethrough', to: 'articlenotifications#link_articlethrough', as: :link_articlethrough
  get 'articlenotifications', to: 'articlenotifications#index'
  get 'articlenotifications_all_read', to: 'articlenotifications#index_all_read'
  resources :articlenotifications do
    post :read_all, on: :collection
  end
  
  resources :categories do
    resources :follows, :controller => 'follows_categories', :only => [:create, :destroy]
  end
  get 'category_search_results', to: "categories#search"
  get 'category/:id/category_articles_search', to: "categories#category_articles_search", as: "category_articles_search"
  get 'category/:id/category_announcements_search', to: "categories#category_announcements_search", as: "category_announcements_search"
  get 'category/:id/category_faqs_search', to: "categories#category_faqs_search", as: "category_faqs_search"
  
  resources :announcements do
    collection do
      patch :sort
    end
    resources :follows, :controller => 'follows_announcements', :only => [:create, :destroy]
    resources :announcement_comments
  end
  post 'announcements/:id/create_announcement_bookmark', to: "announcements#create_announcement_bookmark", as: "create_announcement_bookmark"
  post 'announcements/:id/destroy_announcement_bookmark', to: "announcements#destroy_announcement_bookmark", as: "destroy_announcement_bookmark"
  get 'announcement_search', to: "announcements#announcement_search"
  get 'announcement_search_results', to: "announcements#search"
  get 'user/:id/announcements_bookmark_list', to: "announcements#announcements_bookmark_list", as: "announcements_bookmark_list"
  get 'announcementnotifications/link_announcementthrough'
  get 'announcementnotifications/:id/link_announcementthrough', to: 'announcementnotifications#link_announcementthrough', as: :link_announcementthrough
  get 'announcementnotifications', to: 'announcementnotifications#index'
  get 'announcementnotifications_all_read', to: 'announcementnotifications#index_all_read'
  resources :announcementnotifications do
    post :read_all, on: :collection
  end


  resources :faqs do
    collection do
      patch :sort
    end
    resources :follows, :controller => 'follows_faqs', :only => [:create, :destroy]
    resources :faq_comments
  end
  post 'faqs/:id/create_faq_bookmark', to: "faqs#create_faq_bookmark", as: "create_faq_bookmark"
  post 'faqs/:id/destroy_faq_bookmark', to: "faqs#destroy_faq_bookmark", as: "destroy_faq_bookmark"
  get 'faq_search', to: "faqs#faq_search"
  get 'faq_search_results', to: "faqs#search"
  get 'user/:id/faqs_bookmark_list', to: "faqs#faqs_bookmark_list", as: "faqs_bookmark_list"
  get 'faqnotifications/link_faqthrough'
  get 'faqnotifications/:id/link_faqthrough', to: 'faqnotifications#link_faqthrough', as: :link_faqthrough
  get 'faqnotifications', to: 'faqnotifications#index'
  get 'faqnotifications_all_read', to: 'faqnotifications#index_all_read'
  resources :faqnotifications do
    post :read_all, on: :collection
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  match '*path' => redirect('/'), via: :get
end
