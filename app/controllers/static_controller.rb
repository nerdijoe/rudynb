class StaticController < ApplicationController
  # before_action :require_login, only: [:home]

  def index
  end

  def home
    respond_to do |format|
      format.html { redirect_to home_url }
      format.js
    end
  end

end
