class ThemesController < ApplicationController
  load_and_authorize_resource :profile
  before_filter :load_theme

  def show
    # RANT wish I could just do this: Profiles::Application.assets.find_asset('profile.css.scss.erb').body(self)
    # but Sprockets doesn't allow args to body()
    self.extend(ThemesHelper)
    erb = Tilt.new('app/assets/stylesheets/profile.css.scss.erb').render(self)
    # FIXME why is load_paths not picking up the default?
    scss = Sass::Engine.new(erb, :syntax => :scss, :load_paths => Sass::Plugin.engine_options[:load_paths])
    render :text => scss.render, :content_type => 'text/css'
  end

  def destroy
    @theme.destroy
    redirect_to @profile
  end

  private

  def load_theme
    @theme = @profile.theme
  end

end

# FIXME this must be called in order to populate Sass::Plugin.engine_options
# why?
Compass.configure_sass_plugin!
