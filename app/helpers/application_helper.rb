module ApplicationHelper
  def form_image_select(socialpost)
    return image_tag socialpost.image.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive' if socialpost.image.exists?
    image_tag 'placeholder.jpg', id: 'image-preview', class: 'img-responsive'
  end
  
  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive img-circle profile-image' if user.avatar.exists?
    image_tag 'default-avatar.png', id: 'image-preview',
                                    class: 'img-responsive img-circle profile-image'
  end
  

    
end
