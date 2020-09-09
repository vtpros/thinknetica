# frozen_string_literal: true

require_relative '../accessors'

class TestKlass
  include Accessors

  def initialize(*args)
    attr_accessor_with_history(args)
  end
end
