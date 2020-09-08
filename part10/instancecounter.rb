# frozen_string_literal: true

# module provides a functionality to keep track of initialized class instances
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # method see and set the number of all created class instances
  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  # method to increment a instance counter on initialize
  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end
