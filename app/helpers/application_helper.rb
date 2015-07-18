module ApplicationHelper

  # Icons are different depending if user liked post already or not
  def render_like_icon(post)
    if post.likers.include?(current_user)
      icon_class = 'mdi-action-favorite red-text'
    else
      icon_class = 'mdi-action-favorite-outline red-text'
    end
    content_tag(:i, '', class: icon_class)
  end

  # Text after the like icon depends if user or someone else liked post
  def render_like_text(post)
    if post.likers.include?(current_user) && post.likers.count > 1
      text = "You and #{pluralize((post.likers.count - 1), 'person', 'people')} liked this"
    elsif post.likers.include?(current_user) && post.likers.count == 1
      text = 'You liked this'
    elsif !post.likers.include?(current_user) && post.likers.exists?
      text = "#{pluralize(post.likers.count, 'person', 'people')} liked this"
    else
      text = 'Like'
    end
    content_tag(:p, text, class: 'like_text small-text grey-text')
  end
end
