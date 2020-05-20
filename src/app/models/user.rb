class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings, dependent: :destroy
  has_many :bids, :dependent => :destroy
  has_one_attached :image
  has_many :favourites, :dependent => :destroy
  has_many :orders, :foreign_key => :user_id, :dependent => :destroy
end
