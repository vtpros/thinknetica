# module InstanceCounter
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.instances = 0
    # base.send :include, InstanceMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances += 1
    end
  end
end
