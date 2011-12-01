require 'spec_helper'

describe Message do
  describe '#profile=' do
    context 'given a facebook profile' do
      before do
        @profile = Factory.create(:profile, :facebook_id => '1234')
        @message = Factory.build(:message, :profile => @profile)
      end

      it 'sets the profile_id' do
        @message.profile_id.should eq(@profile.id)
      end

      it 'sets the method to "facebook"' do
        @message.method.should eq('facebook')
      end
    end

    context 'given a non-facebook profile and no smtp server' do
      before do
        @profile = Factory.create(:profile)
        @message = Factory.build(:message, :profile => @profile)
      end

      it 'sets the profile_id' do
        @message.profile_id.should eq(@profile.id)
      end

      it 'sets the method to "mailto"' do
        @message.method.should eq('mailto')
      end
    end
  end

  describe '#profile_id=' do
    before do
      @profile = Factory.create(:profile, :facebook_id => '1234')
      Profile.stubs(:find).returns(@profile)
      @message = Factory.build(:message, :profile_id => @profile.id)
    end

    # FIXME mocha/bourne have_received isn't working for some reason; punting for now
    #it 'calls Profile.find(id)' do
      #Profile.should have_received(:find).with(@profile.id)
    #end

    it 'sets the profile_id' do
      @message.profile_id.should eq(@profile.id)
    end
  end
end
