# frozen_string_literal: true

# Accessors module
module Accessors
  def attr_accessor_with_history(args)
    args.each do |name|
      instance_variable_set("@#{name}_history", [])

      self.class.define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
        instance_variable_get("@#{name}_history") << value
      end

      self.class.send(:attr_reader, name, "#{name}_history")
    end
  end

  def strong_attr_accessor(name, klass)
    instance_variable_set("@#{name}_class", klass)

    self.class.define_method("#{name}=") do |value|
      klass = instance_variable_get("@#{name}_class")
      raise ArgumentError, "value should be #{klass}" unless value.is_a?(klass)

      instance_variable_set("@#{name}", value)
    end

    self.class.send(:attr_reader, name)
  end
end
