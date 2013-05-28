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
    @page = @user.pages.first.id
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

  def photo
    logger.debug "POST photo user #{params[:id]} page #{params[:page_id]} #{params[:inputPhotoTarget]}"
    user = User.find_by_id(params[:id])
    if (user)
      page = user.pages.find_by_id(params[:page_id])
      if page
        logger.debug "POST found page"
        photos = page.photos.where(layout_position = 1)
        if (photos.count == 0)
          photo = Photo.new
          photo.layout_position = 1
          photo.image_url = params[:inputPhotoTarget]
          page.photos << photo
        else
          photos.first.image_url = params[:inputPhotoTarget]
          photos.first.save
        end
      end
    end
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
