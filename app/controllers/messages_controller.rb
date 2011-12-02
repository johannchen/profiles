class MessagesController < ApplicationController
  load_and_authorize_resource :profile
  load_and_authorize_resource :message, :through => :profile
  before_filter :set_message_from

  respond_to :html

  def new
    case @message.method
    when 'facebook'
      if params[:_pjax]
        # force pjax to do a full request
        render :text => 'full http request necessary', :status => 500
      else
        @message.save!
        redirect_to fb_message_url(@profile)
      end
    when 'mailto'
      @message.save!
    end
  end

  def create
    if @message.update_attributes(params[:message])
      flash[:success] = t('messages.form.save_success')
      redirect_to @profile
    else
      respond_with(@message)
    end
  end

  private

  def set_message_from
    @message.from = current_user.profile
  end

  def fb_message_url(profile)
    return '' unless profile.facebook_id
    "https://www.facebook.com/dialog/send?" +
    {
      :app_id       => Setting.s('auth.facebook.app.id'),
      :to           => profile.facebook_id,
      :redirect_uri => profile_url(profile)
    }.to_param
  end
end
