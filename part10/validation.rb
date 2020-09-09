# frozen_string_literal: true

# Validation module
module Validation
  def validate!(value:, validation_type:, arg: nil)
    valid = validate(value: value, validation_type: validation_type, arg: arg)
    valid == :valid ? value : (raise ArgumentError, valid)
  end

  def validate(value:, validation_type:, arg: nil)
    case validation_type
    when :presence
      present?(value)        ? :valid : 'should not be nil or empty'
    when :format
      formatted?(value, arg) ? :valid : 'does not match format regex'
    when :type
      typed?(value, arg)     ? :valid : "should be #{arg}"
    else raise ArgumentError, 'validation type is not supported'
    end
  end

  private

  def present?(name)
    !(name.nil? || name.empty?)
  end

  def formatted?(name, regexp)
    name =~ regexp
  end

  def typed?(name, klass)
    name.is_a? klass
  end
end
