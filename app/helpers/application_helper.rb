module ApplicationHelper
def form_image_select(socialpost)
  return image_tag socialpost.image.url(:medium),
                   id: 'image-preview',
                   class: 'img-responsive' if socialpost.image.exists?
  image_tag 'placeholder.jpg', id: 'image-preview', class: 'img-responsive'
end

    
end
