class UsersController < Clearance::UsersController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js
      end
      # redirect_to sign_in_path
    else
      render root_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :phone, :nationality, :email, :password)
  end

end
