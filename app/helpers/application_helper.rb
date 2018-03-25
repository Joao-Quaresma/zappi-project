module ApplicationHelper
  def alert_for(flash_type)
    {
      success: 'alert-success text-center',
      error: 'alert-danger text-center',
      alert: 'alert-warning text-center',
      notice: 'alert-info text-center'
    }[flash_type.to_sym] || flash_type.to_s
  end
  
  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive img-circle profile-image' if user.avatar.exists?
    image_tag 'default-avatar.png', id: 'image-preview',
                                    class: 'img-responsive img-circle profile-image'
  end
  
    
  def form_image_select(socialpost)
    return image_tag socialpost.image.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive' if socialpost.image.exists?
    image_tag 'placeholder.png', id: 'image-preview', class: 'img-responsive'
  end
  
  def markdownify(content)
    pipeline_context = {gfm: true, asset_root: "https://a248.e.akamai.net/assets.github.com/images/icons"}
    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::EmojiFilter,
    ], pipeline_context
    pipeline.call(content)[:output].to_s
  end
    
end
