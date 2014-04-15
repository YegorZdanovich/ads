require 'spec_helper'

describe Type do
  
  subject {Type.create! value: "test type"}

  it 'should be valid' do
    subject.should be_valid
  end

  it 'should not be valid' do
    expect(Type.create value: "").to have(1).errors_on(:value)
  end

  it 'should be uniq' do
    type1 = Type.create value: "test type"
    type2 = Type.create value: "test type"

    expect(type2).to have(1).errors_on(:value)    
  end

end