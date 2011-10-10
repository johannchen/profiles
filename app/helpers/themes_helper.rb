module ThemesHelper

  def theme_head_markup(theme)
    # font inclusion
    if theme
      fonts = %w(name_font_family headline_font_family bio_font_family).map { |f| theme.send(f) }.uniq.compact
      content_tag(:link, '', :href => "http://fonts.googleapis.com/css?family=#{fonts.join('|').sub(/\s/, '+')}", :rel => 'stylesheet', :type => 'text/css')
    end
  end

  def theme_body_markup(theme)
    # image byline
    if theme && theme.bg_image_byline
      content_tag(:div, :id => 'bg-byline') do
        t('profile.theme.bg_image_byline_html', :name => theme.bg_image_name, :byline => theme.bg_image_byline)
      end
    end
  end

  def theme_stylesheet_link_tag
    return unless @profile && @profile.theme
    stylesheet_link_tag(profile_theme_path(@profile, :m => @profile.theme.updated_at.to_f))
  end

  # build a css font shorthand rule
  def font_style(theme, prefix)
    style = []
    style << theme.send("#{prefix}_font_style")
    style << @theme.send("#{prefix}_font_variant")
    style << @theme.send("#{prefix}_font_weight")
    style << "#{@theme.send("#{prefix}_size")}pt"
    style << "/#{@theme.send("#{prefix}_line_height")}em" if @theme.send("#{prefix}_line_height")
    style << "\"#{@theme.send("#{prefix}_font_family")}\", arial, sans-serif"
    style.compact.join(' ')
  end

end
