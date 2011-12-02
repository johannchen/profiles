require 'spec_helper'

describe AdminStatsPresenter do
  describe '#sign_ups_by_date' do
    before do
      @profile = Factory.build(:profile, :created_at => Time.now)
      Profile.stub(:where).and_return([@profile])
    end

    it 'returns a hash with dates as keys and counts as values' do
      counts = subject.sign_ups_by_date
      counts.keys.map(&:to_s).should have(30).dates
      counts.keys[-2..-1].should eq([Date.today-1, Date.today])
      counts.values[-2..-1].should eq([[], [@profile]])
    end
  end
end
