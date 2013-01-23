class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #ratings
  letsrate_rateable "Credibility"
  letsrate_rater
  # Setup accessible (or protected) attributes for your model
  attr_accessible :firstname, :lastname, :birthday, :address, :contact, :rating,
                  :aboutme, :email, :password, :password_confirmation, :remember_me

  #validation
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birthday, presence: true
  validates :address, presence: true
  validates :contact, presence: true
  
  # attr_accessible :title, :body
  #
  has_many :products
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :mails

  def current_user?(user)
     user == current_user
  end

  def self.values_for_select
    all.map{ |u| [u.email, u.id] }
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def feed
    Product.from_users_followed_by(self)
  end
end

