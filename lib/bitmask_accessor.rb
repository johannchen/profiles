module BitmaskAttributeAccessor
  extend ActiveSupport::Concern

  module ClassMethods
    def bitmask_accessor(attribute, value, options={})
      method_name = "#{value}#{options[:suffix]}"
      class_eval <<-END
        def #{method_name}() #{attribute}?(:#{value}) end
        alias_method :#{method_name}?, :#{method_name}

        def #{method_name}=(bool)
          if [0, false, nil, '0', 'false'].include?(bool)
            #{attribute}.delete(:#{value})
          else
            #{attribute} << :#{value}
          end
        end
      END
    end
  end
end

ActiveRecord::Base.send :include, BitmaskAttributeAccessor
