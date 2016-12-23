class User < ActiveRecord::Base
  include Clearance::User

  has_many :authentications, :dependent => :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)

    # user = Authentication.create(name: auth_hash["name"], email: auth_hash["extra"]["raw_info"]["email"])
    # user.authentications<<(authentication)

    create! do |u|
      u.firstname = auth_hash["extra"]["raw_info"]["name"]
      u.lastname = auth_hash["extra"]["raw_info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]
      u.authentications << (authentication)
      u.password = SecureRandom.hex(3)
      byebug
    end


  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

end
