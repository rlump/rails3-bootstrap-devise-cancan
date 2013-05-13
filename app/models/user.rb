class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :provider, :uid

  has_many :subject_relations, :as => :subjectable
  has_many :predicate_relations, :as => :predicable

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.name = data["name"] if user.name.blank?
        user.oauth_token = data["credentials"]["token"]
        user.oauth_expires_at = data["credentials"]["expires_at"]
      end
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
    user = User.create(name:auth.extra.raw_info.name,
                       provider:auth.provider,
                       uid:auth.uid,
                       email:auth.info.email,
                       password:Devise.friendly_token[0,20]
                       )
    end
    if user
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = auth.credentials.expires_at
    end
    user
  end


  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def albums
    if not @albums
      @albums = []
      self.facebook.get_connections("me","albums").each do |fb_album|
        new_album = Album.new
        new_album.image_url = self.facebook.get_object(fb_album["cover_photo"])["picture"]
        new_album.name = fb_album["name"]
        @albums << new_album
      end
    end
    @albums
  end

end
