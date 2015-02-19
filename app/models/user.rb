class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable
  has_many :trysts
  
  def display_name
    email
  end

  before_create :create_access_token
  def create_access_token
    return true if access_token.present?
    begin
      access_token = SecureRandom.urlsafe_base64
    end while User.where(access_token: access_token).exists?
    self.access_token = access_token
  end
end
