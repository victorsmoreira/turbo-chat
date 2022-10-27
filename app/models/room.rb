class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3 }

  broadcasts_to ->(_) { "rooms" }
end
