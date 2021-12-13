class Admin::BaseController < ApplicationController
  before_action :authenticate_current_admin!

  def authenticate_current_admin!
    if !current_user || !(current_user.is_admin?)
      flash[:alert] = "Not authorized"
      redirect_to petitions_path
    end
  end

end

