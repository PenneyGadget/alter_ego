class AdminsController < ApplicationController
  def new
    @admin = User.new
  end

  def create
    @admin = User.create(admin_params)
  end

  private

  def admin_params
    admin_hash = params.require(:admin).permit(:name,
                                               :tagline,
                                               :username,
                                               :password,
                                               :password_confirmation)
    admin_hash[:role] = 1
  end

end
