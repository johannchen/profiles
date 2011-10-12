module ApplicationHelper
  def flash_messages
    [:info, :success, :warning, :error].map do |type|
      if flash[type]
        content_tag(:div, :class => "alert-message #{type}") do
          link_to('x', '#', :class => 'close') +
          content_tag(:p, h(flash[type]))
        end
      end
    end.join.html_safe
  end

  def errors_for(form_or_resource, options={})
    if form_or_resource.respond_to?(:object)
      obj = form_or_resource.object
    else
      obj = form_or_resource
    end
    if obj.errors.any?
      content_tag(:div, class: 'error_explanation') do
        content_tag(:h3, t('feedback.form_errors_heading')) +
        content_tag(:ul) do
          obj.errors.map do |attribute, message|
            if !options[:only] or options[:only].include?(attribute)
              content_tag(:li, h(message))
            end
          end.join.html_safe
        end
      end
    end
  end

  def simple_url(url)
    url.sub(/^https?:\/\/(www\.)?/, '')
  end

  def body_class
    [].tap do |classes|
      if @profile
        classes << 'profile'
        classes << @profile.theme.bg_class if @profile.theme
      end
    end.join(' ')
  end

  def sanitize(html)
    Sanitize.clean(html, Sanitize::Config::BASIC).html_safe
  end

end
