class Room < ApplicationRecord
  has_many :messages

  validates :title, presence: true, length: { minimum: 3 }
end
