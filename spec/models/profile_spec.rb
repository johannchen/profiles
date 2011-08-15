require 'spec_helper'

describe Profile do
  subject { Factory.build(:profile) }

  it 'accepts a nil gender' do
    subject.gender = 'nil'
    subject.gender.should be_nil
  end
end
