class SessionsController < Clearance::SessionsController

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
        # home_url
      else
        # flash.now[:notice] = 'Ballz.'
        # flash.now.notice = flash.now[:notice]
        # render template: "sessions/new", status: :unauthorized

        # use ajax here
        respond_to do |format|
          format.html { redirect_to sign_in_url }
          format.js
        end

      end
    end
  end


end
