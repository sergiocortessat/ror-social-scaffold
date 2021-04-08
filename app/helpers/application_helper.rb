module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def btn_send(user)
    return if current_user.pending_friends.include?(user)
    return if current_user.friends.include?(user)
    return if current_user.friend_requests.include?(user)

    (button_to 'Send request', user_friendships_path(user), method: :post)
  end

  def btn_mutual(user)
    return if user.friends.include?(nil)

    mutuals = []
    user.friends.map do |friend|
      current_user.friends.map { |friendd| friendd == friend ? mutuals.push(friend.name) : mutuals }
    end
    mutuals.uniq
  end

  def all_users(user)
    return unless user != current_user

    content_tag(:div) do
      content_tag(:h4, user.name) +
        (link_to 'See Profile', user_path(user), class: 'profile-link') +
        btn_send(user) +
        btn_mutual(user)
    end
  end
end
