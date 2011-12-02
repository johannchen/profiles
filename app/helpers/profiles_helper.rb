module ProfilesHelper

  SILHOUETTE_IMAGES = {
    :full => {
      'm' => 'manoutline.png',
      'f' => 'womanoutline.png',
      nil => 'questionoutline.png'
    },
    :tn => {
      'm' => 'manoutline.tn.png',
      'f' => 'womanoutline.tn.png',
      nil => 'questionoutline.tn.png'
    }
  }

  def profile_pic_tag(profile, type=:full)
    content_tag(:div, :class => 'pic') do
      if url = {:full => profile.full_image_url, :tn => profile.small_image_url}[type]
        image_tag(url, :alt => profile.name)
      else
        image_tag(SILHOUETTE_IMAGES[type][profile.gender], :alt => profile.name)
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
      (options[:close] ? close_button : '') +
      content_tag(:h2, t("profile.alert_#{content}.heading")) +
      content_tag(:p,  t("profile.alert_#{content}.body_html")) +
      content_tag(:div, :class => 'alert-actions') do
        actions.join("\n").html_safe
      end
    end
  end

  def profile_alerts
    return unless @profile && @profile.user == current_user
    [].tap do |alerts|
      if @profile.alerts?(:new)
        alerts << alert_block(:success, :new, [
                    link_to(t('profile.alert_new.edit_profile_button'), edit_profile_path(@profile), :class => 'btn small')])
      end
      if @profile.alerts?(:new_theme)
        alerts << alert_block(:info, :new_theme, [
                    link_to(t('profile.alert_new_theme.new_button'), profile_theme_path(@profile), :method => :delete, :class => 'btn small'),
                    link_to(t('profile.alert_new_theme.edit_button'), edit_profile_path(@profile, :tab => 'theme'), :class => 'btn small')])
      end
    end.join("\n").html_safe
  end

  def profile_view(&block)
    content = capture(&block)
    if params[:_pjax]
      content_tag(:div, :class => 'content') do
        close_button + content
      end
    else
      content_for(:aux) do
        content_tag(:div, :class => 'content') do
          close_button + content
        end
      end
      render(:file => 'profiles/show')
    end
  end

  def event_url(date, title, url=nil)
    "https://www.google.com/calendar/b/0/render?" +
    {
      :action   => 'TEMPLATE',
      :text     => title,
      :dates    => "#{date.strftime('%Y%m%d')}/#{(date + 1).strftime('%Y%m%d')}",
      :details  => '',
      :location => '',
      :trp      => false,
      :sprop    => url || request.url,
      :pli      => 1,
      :sf       => true,
      :output   => 'xml'
    }.to_param
  end

end
