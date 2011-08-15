module ProfilesHelper
  def profile_pic_tag(profile)
    img = {
      'm' => 'manoutline.png',
      'f' => 'womanoutline.png',
      nil => 'questionoutline.png'
    }[profile.gender]
    image_tag(img, :alt => profile.name)
  end
end
