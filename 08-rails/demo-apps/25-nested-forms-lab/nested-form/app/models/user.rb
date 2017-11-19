class User < ApplicationRecord
  has_many :addresses
  belongs_to :team
end
