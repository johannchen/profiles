require 'acceptance/acceptance_helper'

feature 'Sign Up', %q{
  In order to sign up
  As a user
  I want to enter an email, password, and any other required details
  And gain access to the site.
} do

  scenario 'user signs up with email and password and is asked to create a profile' do
    visit sign_up_page
    fill_in 'user_email',                 :with => 'tim@example.com'
    fill_in 'user_password',              :with => 'password'
    fill_in 'user_password_confirmation', :with => 'password'
    check 'user_thirteen_or_older'
    click_on 'Sign Up'
    page.should have_content('Please create your profile in order to continue.')
  end

  scenario 'user signs up without indicating they are thirteen or older' do
    visit sign_up_page
    fill_in 'user_email',                 :with => 'tim@example.com'
    fill_in 'user_password',              :with => 'password'
    fill_in 'user_password_confirmation', :with => 'password'
    click_on 'Sign Up'
    page.should have_css('.error #user_thirteen_or_older')
    page.should have_content('is invalid')
  end
end
