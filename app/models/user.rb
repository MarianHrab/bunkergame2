class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :owned_rooms, class_name: 'Room', foreign_key: 'owner_id'
  has_many :players, dependent: :destroy
  has_many :rooms, through: :players

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
