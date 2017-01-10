require "rails_helper"

# require "./app/controllers/users_controller"

describe UsersController do
  let(:firstname) {'David'}
  let(:lastname) {'Johnson'}
  let(:email) {'dj@haha.com'}
  let(:phone) {'123'}
  let(:nationality) {'American'}
  let(:password) { 'haha'}
  let(:user) {User.new(firstname: firstname, lastname: lastname, email: email, phone: phone, nationality:nationality, password: password )}

  describe "#create" do
    it "creates new user" do
      expect(User.new(firstname: 'ijo', lastname: 'man', email: 'ijo@haha.com', phone: '123', nationality: 'Japan', password: 'haha')).to be_a_kind_of(User)
    end
  end
end
