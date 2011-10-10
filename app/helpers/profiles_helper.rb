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

  def profile_bio(profile)
    if profile.bio
      if profile.bio =~ /\r?\n\r?\n/ and profile.bio !~ /<p>|<br\s*\/?>/
        # replace \n\n with <br /><br />
        sanitize profile.bio.gsub(/\r?\n\r?\n/, "<br />\n<br />\n")
      else
        sanitize profile.bio
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
    content_tag(:div, :class => "alert-message block-message #{alert_class}", :id => content) do
      if options[:close]
        content_tag(:a, '&#215;'.html_safe, :href => '#', :class => 'close')
      end.to_s +
      content_tag(:h2, t("profile.alert_#{content}.heading")) +
      content_tag(:p,  t("profile.alert_#{content}.body_html")) +
      content_tag(:div, :class => 'alert-actions') do
        actions.join("\n").html_safe
      end
    end
  end

  def profile_alerts
    return unless @profile
    [].tap do |alerts|
      if @profile.alerts?(:new)
        alerts << alert_block(:success, :new, [
                    link_to(t('profile.alert_new.edit_profile_button'), edit_profile_path(@profile), :class => 'btn small')])
      end
      if @profile.alerts?(:new_theme)
        alerts << alert_block(:info, :new_theme, [
                    link_to(t('profile.alert_new_theme.new_button'), profile_theme_path(@profile), :method => :delete, :class => 'btn small'),
                    link_to(t('profile.alert_new_theme.edit_button'), edit_profile_path(@profile), :class => 'btn small', :onclick => "alert('not working yet'); return false")])
      end
    end.join("\n").html_safe
  end

end
