module ApplicationHelper
  def avatar_large(user)
    if user.avatar.attached?
      cl_image_tag(current_user.avatar.key, transformation: [
        { width: 800, height: 800, gravity: 'face', radius: 'max', crop: 'fill' }
      ], class: "avatar-large")
    else
      image_tag('default-user-avatar.png', class: "avatar-large")
    end
  end

  def avatar_small(user)
    if user.avatar.attached?
      cl_image_tag(current_user.avatar.key, transformation: [
        { width: 800, height: 800, gravity: 'face', radius: 'max', crop: 'fill' }
      ], class: "avatar")
    else
      image_tag('default-user-avatar.png', class: "avatar")
    end
  end
end

