class Friend < ApplicationRecord
has_many :names
has_many :addresses
belongs_to :user
validates :name, presence: true, length: { minimum: 3 }
validates :address, presence: true
end
