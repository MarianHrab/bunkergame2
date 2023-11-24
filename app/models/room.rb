class Room < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :players
  has_many :users, through: :players
end