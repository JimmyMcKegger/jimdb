# frozen_string_literal: true

module UsersHelper
  def profile_image(user)
    gravatar_id = user.gravatar_id
    if gravatar_id.present?
      url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    else
      hash = Digest::MD5.hexdigest(user.email.downcase)
      url = "https://www.gravatar.com/avatar/#{hash}?d=identicon"
    end
    image_tag(url, alt: user.name)
  end
end
