require 'spec_helper'

describe MessagesController do
  describe 'GET new' do
    context 'given a facebook profile' do
      before do
        MessagesController.any_instance.stub(:fb_message_url).and_return('https://www.facebook.com/message')
        @profile = Factory.create(:profile, :facebook_id => '1234')
        sign_in @profile.user
        get :new, :profile_id => @profile.id
      end

      it 'initializes and saves a new @message' do
        msg = assigns(:message)
        msg.profile.should eq(@profile)
        msg.should_not be(:new_record?)
      end

      it 'redirects to fb message url' do
        response.should redirect_to('https://www.facebook.com/message')
      end
    end

    context 'given a non-facebook profile and no configured smtp server' do
      before do
        @profile = Factory.create(:profile)
        sign_in @profile.user
        get :new, :profile_id => @profile.id
      end

      it 'initializes and saves a new @message' do
        msg = assigns(:message)
        msg.profile.should eq(@profile)
        msg.should_not be(:new_record?)
      end

      it 'shows the template' do
        response.should render_template('new')
      end
    end
  end
end
