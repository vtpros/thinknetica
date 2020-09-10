# frozen_string_literal: true

# Validation module
module Validation
  def validate!(value:, validation_type:, arg: nil)
    valid = validate(value: value, validation_type: validation_type, arg: arg)
    valid == :valid ? value : (raise ArgumentError, valid)
  end

  def validate(value:, validation_type:, arg: nil)
    send "validate_#{validation_type}", value, arg
  end

  private

  def validate_presence(name, _)
    !(name.nil? || name.empty?) ? :valid : 'should not be nil or empty'
  end

  def validate_format(name, regexp)
    name =~ regexp ? :valid : 'does not match format regex'
  end

  def validate_type(name, klass)
    name.is_a?(klass) ? :valid : "should be #{arg}"
  end
end
