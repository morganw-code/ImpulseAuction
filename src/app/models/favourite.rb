class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validates_uniqueness_of :user, :scope => :listing
end
