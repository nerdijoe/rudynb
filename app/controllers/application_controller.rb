class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authorize


  def hello
    render html: "hello, rudy!"
  end

  def allow?(controller, action)
    if current_user.customer?
      # controller == 'listings' && action == 'index'
      controller == 'listings' && action.in?(%w[index show])
    end
  end


  private
  def authorize    
    if !allow?(params[:controller], params[:action])
      redirect_to listings_path, alert: "Not authorized"
    end
  end




end
