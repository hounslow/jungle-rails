class User < ActiveRecord::Base

  has_secure_password
  has_many :orders
  has_many :reviews
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  # before_validation :strip_whitespace, :only => [:email]

  def self.strip_whitespace(email)
    email.strip unless email.nil?
  end

  def self.authenticate_with_credentials(email, password)
    email = User.strip_whitespace(email)
    @user = User.where("email ILIKE ?", email).first
    if @user
      @user.authenticate(password)
    end
  end
end
