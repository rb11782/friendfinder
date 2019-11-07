class Friend < ApplicationRecord
has_many :names
has_many :addresses
belongs_to :user
end
