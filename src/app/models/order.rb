class Order < ApplicationRecord
  belongs_to :listing
  belongs_to :user, :foreign_key => :user_id, class_name: "User"
end