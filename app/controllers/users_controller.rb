class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    logger.debug "GET Users album:"
    @albums = @user.albums
    logger.debug "GOT Users album:"
    @page = 0
    if (params[:album_id])
      logger.debug "GET Users photos:"
      index = params[:album_id].to_i
      @photos = @user.albums(index)
    else
      @photos = @albums
    end
  end

  def page
    @user = User.find(params[:id])
    @page = params[:page_id]
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
