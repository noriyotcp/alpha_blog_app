module FeatureHelper
  def login
    @user = User.create!(email: "john@example.com", password: "password")
    login_as(@user)
  end
end
