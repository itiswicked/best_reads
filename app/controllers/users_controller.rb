class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    render plain: "You are not authorized to view this." unless user_signed_in?
  end
end
