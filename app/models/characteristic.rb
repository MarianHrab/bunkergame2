class Characteristic < ApplicationRecord
  belongs_to :player, dependent: :destroy
end
