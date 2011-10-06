module ProfilesHelper

  SILHOUETTE_IMAGES = {
    'm' => 'manoutline.png',
    'f' => 'womanoutline.png',
    nil => 'questionoutline.png'
  }

  def profile_pic_tag(profile)
    content_tag(:div, :class => 'pic') do
      if profile.full_image_url
        image_tag(profile.full_image_url, :alt => profile.name)
      else
        image_tag(SILHOUETTE_IMAGES[profile.gender], :alt => profile.name)
      end
    end
  end

  def layout_order(theme)
    {
      :left  => ['profile-box', 'alerts'],
      :right => ['alerts', 'profile-box']
    }[theme.box_pos.to_sym]
  end

  def alert_block(alert_class, content, actions, options={})
    options.reverse_merge!(:close => true)
    content_tag(:div, :class => "alert-message block-message #{alert_class} #{content}") do
      if options[:close]
        content_tag(:a, '&#215;'.html_safe, :href => '#', :class => 'close')
      end.to_s +
      content_tag(:h2, t("profile.#{content}.heading")) +
      content_tag(:p,  t("profile.#{content}.body_html")) +
      content_tag(:div, :class => 'alert-actions') do
        actions.join("\n").html_safe
      end
    end
  end

end
