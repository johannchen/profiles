# for compatibility with Twitter Bootstrap

SimpleForm.wrapper_class = 'clearfix'
SimpleForm.wrapper_error_class = 'error'
SimpleForm.error_class = 'help-inline'
SimpleForm.item_wrapper_tag = 'li'

# override default label to wrap input with div.input
module SimpleForm::Components::LabelInput
  def label_input
    (options[:label] == false ? "" : label) + template.content_tag(:div, input, :class => 'input')
  end
end

# radio buttons
module SimpleForm::ActionViewExtensions::Builder
  def collection_radio(attribute, collection, value_method, text_method, options={}, html_options={})
    template.content_tag(:ul, :class => 'inputs-list') do
      render_collection(
        attribute, collection, value_method, text_method, options, html_options
      ) do |value, text, default_html_options|
        template.content_tag(:label) do
          radio_button(attribute, value, default_html_options) +
          template.content_tag(:span, text)
        end
      end
    end
  end
end

# Specialized Inputs for Twitter Bootstrap (prefixed with b_)
module SimpleForm::Inputs
  class BBooleanInput < BooleanInput
    def input
      template.content_tag(:div, :class => 'input') do
        template.content_tag(:ul, :class => 'inputs-list') do
          template.content_tag(:li, :class => options[:inline] && 'inline') do
            if options[:inline]
              @builder.label(label_target, @builder.check_box(attribute_name, input_html_options) + template.content_tag(:span, label_text), label_html_options)
            else
              @builder.check_box(attribute_name, input_html_options)
            end
          end
        end
      end
    end

    def label_input
      if options[:inline]
        input
      else
        (options[:label] == false ? "" : label) + input
      end
    end
  end
end
