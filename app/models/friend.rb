class Friend < ApplicationRecord
belongs_to :user
geocoded_by :address
after_validation :geocode
has_many :names
# has_many :addresses
validates :name, presence: true, length: { minimum: 3 }
validates :address, presence: true
end
