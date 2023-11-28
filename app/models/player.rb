class Player < ApplicationRecord
  serialize :opened_characteristics, Array, coder: JSON
  serialize :visible_characteristics, Array, coder: JSON
  belongs_to :user
  belongs_to :room
  has_one :characteristic, dependent: :destroy
end
