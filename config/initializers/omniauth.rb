#In config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'], scope: "public_profile, user_birthday"

  provider :twitter, ENV['TWITTER_APP_KEY'], ENV['TWITTER_APP_SECRET'],
  {
    :secure_image_url => 'true',
    :image_size => 'original',
    :authorize_params => {
     :force_login => 'true'
    }
  }
end
