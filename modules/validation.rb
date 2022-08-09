# frozen_string_literal: true

module Validation
  def validate_string!(value, name)
    raise ArgumentError, "#{name} should be a string" unless value.is_a?(String)
  end

  def validate_number!(value, name)
    raise ArgumentError, "#{name} should be an integer" unless value.is_a?(Integer)
  end

  def validate_positive!(value, name)
    raise ArgumentError, "#{name} should be greater than 0" if value <= 0
  end

  def validate_class!(object, class_name, object_name)
    raise ArgumentError, "#{object_name} is not a #{class_name} class" unless object.is_a?(class_name)
  end
end
