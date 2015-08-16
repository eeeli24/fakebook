module ApplicationHelper

  # Icons are different depending if user liked the post already or not
  def render_like_icon(post)
    icon_class = if post.likers.include?(current_user)
                    'mdi-action-favorite red-text'
                 else
                    'mdi-action-favorite-outline red-text'
                 end
    content_tag(:i, '', class: icon_class)
  end

  # Text after the like icon depends if user or someone else liked the post
  def render_like_text(post)
    text = case
           when post.likers.include?(current_user) && post.likers.count > 1
             "You and #{pluralize((post.likers.count - 1), 'person', 'people')} liked this"
           when post.likers.include?(current_user) && post.likers.count == 1
             'You liked this'
           when !post.likers.include?(current_user) && post.likers.exists?
             "#{pluralize(post.likers.count, 'person', 'people')} liked this"
           else
             'Like'
           end
    content_tag(:p, text, class: 'like_text small-text grey-text')
  end
end
