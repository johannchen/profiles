module ProfilesHelper

  SILHOUETTE_IMAGES = {
    'm' => 'manoutline.png',
    'f' => 'womanoutline.png',
    nil => 'questionoutline.png'
  }

  def profile_pic_tag(profile)
    if profile.full_image_url
      image_tag(profile.full_image_url, :alt => profile.name)
    else
      image_tag(SILHOUETTE_IMAGES[profile.gender], :alt => profile.name)
    end
  end

end
