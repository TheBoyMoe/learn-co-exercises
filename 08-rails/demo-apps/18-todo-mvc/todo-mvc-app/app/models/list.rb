class List < ApplicationRecord
  # associations add methods to the model
  has_many :items

  validates :name, presence: true
end
