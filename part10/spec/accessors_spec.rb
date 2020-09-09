# frozen_string_literal: true

require_relative 'testklass'

test_instance = TestKlass.new('var1', 'var2', 'var3')

describe TestKlass do
  it 'should set instance variables on initialize' do
    variable = test_instance.instance_variable_get('@var1')
    expect(variable).to eq nil
  end

  it 'should set instance variables' do
    test_instance.var1 = 1
    variable = test_instance.instance_variable_get('@var1')
    expect(variable).to eq 1
  end

  it 'should set instance variables' do
    test_instance.var1 = 2
    variable = test_instance.instance_variable_get('@var1')
    expect(variable).to eq 2
  end

  it 'should get instance variables history' do
    variable = test_instance.var1_history
    expect(variable).to eq [1, 2]
  end

  it 'should set instance variables via strong_attr_accessor' do
    test_instance.strong_attr_accessor('var4', Integer)
    variable = test_instance.instance_variable_get('@var4')
    expect(variable).to eq nil
  end

  it 'should check for value type' do
    test_instance.var4 = 1
    variable = test_instance.instance_variable_get('@var4')
    expect(variable).to eq 1
  end

  it 'should fail on wrong value type' do
    expect { test_instance.var4 = 'text' }.to raise_error(ArgumentError)
  end
end
