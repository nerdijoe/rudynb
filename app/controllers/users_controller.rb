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
      redirect_to root_path, alert: "Cannot signup"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      # redirect_to action: 'show', id: @user.id
      redirect_to user_path(@user)
    else
      # render action: 'edit'
      redirect_to user_path(@user), alert: "System error, cannot update your profile"
    end
  end


  def edit_profile_pic
    @user = User.find(params[:id])
  end

  # def update_profile_pic
  #   @user = User.find(params[:id])
  #   @user.profile_pic = user_params[:profile_pic]
  #
  #   byebug
  #   if @user.save
  #     redirect_to action: 'show', id: @user.id
  #   else
  #     # render action: 'edit'
  #     redirect_to action: 'show', id: @user.id, alert: "System error, cannot update your profile picture"
  #   end
  #
  # end
  #

  def reservations
    @reservations = current_user.reservations
  end


  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :phone, :nationality, :email, :password, :profile_pic)
  end

end
