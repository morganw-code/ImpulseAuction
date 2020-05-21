class Listing < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    has_many :bids, :dependent => :destroy
    has_many :favourites, :dependent => :destroy
    has_many :orders, :dependent => :destroy
    validates :title, :description, :starting_price, :image, :relist, presence: true
end
