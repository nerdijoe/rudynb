class User < ActiveRecord::Base
  include Clearance::User

  # Associations
  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy

  enum role: [ :customer, :moderator, :superadmin ]

  mount_uploader :profile_pic, ImageUploader


  def self.create_with_auth_and_hash(authentication, auth_hash)

    # user = Authentication.create(name: auth_hash["name"], email: auth_hash["extra"]["raw_info"]["email"])
    # user.authentications<<(authentication)

    create! do |u|
      u.firstname = auth_hash["extra"]["raw_info"]["name"]
      u.lastname = auth_hash["extra"]["raw_info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.email = auth_hash.uid + '@twitter.com' if auth_hash.provider == 'twitter'
      u.authentications << (authentication)
      u.password = SecureRandom.hex(3)

      u.profile_pic = auth_hash['info']['image']

      byebug
    end


  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

end
