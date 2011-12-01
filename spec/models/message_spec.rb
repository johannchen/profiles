require 'spec_helper'

describe Message do
  describe '#set_method' do
    context 'given a facebook recipient' do
      before do
        @profile = Factory.create(:profile, :facebook_id => '1234')
        @message = Factory.build(:message, :profile => @profile)
      end

      it 'sets the method to "mailto"' do
        @message.method.should eq('mailto')
      end

      context 'given a facebook sender' do
        before do
          @message.from = Factory.create(:profile, :facebook_id => '4321')
        end

        it 'sets the method to "facebook"' do
          @message.method.should eq('facebook')
        end
      end
    end

    context 'given a non-facebook recipient and no smtp server' do
      before do
        @profile = Factory.create(:profile)
        @message = Factory.build(:message, :profile => @profile)
      end

      it 'sets the method to "mailto"' do
        @message.method.should eq('mailto')
      end
    end

    describe 'triggers' do
      before do
        @profile = Factory.create(:profile)
        @message = Factory.build(:message)
        @message.stub(:set_method)
      end

      describe '#profile=' do
        before do
          @message.profile = @profile
        end

        it 'calls set_method' do
          @message.should have_received(:set_method)
        end

        it 'sets the profile_id' do
          @message.profile_id.should eq(@profile.id)
        end
      end

      describe '#profile_id=' do
        before do
          @message.profile_id = @profile.id
        end

        it 'calls set_method' do
          @message.should have_received(:set_method)
        end

        it 'sets the profile_id' do
          @message.profile_id.should eq(@profile.id)
        end
      end

      describe '#from=' do
        before do
          @message.from = @profile
        end

        it 'calls set_method' do
          @message.should have_received(:set_method)
        end

        it 'sets the from_id' do
          @message.from_id.should eq(@profile.id)
        end
      end

      describe '#from_id=' do
        before do
          @message.from_id = @profile.id
        end

        it 'calls set_method' do
          @message.should have_received(:set_method)
        end

        it 'sets the from_id' do
          @message.from_id.should eq(@profile.id)
        end
      end
    end
  end
end
