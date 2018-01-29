class Item < ApplicationRecord
  belongs_to :list
  validates :description, presence: true

  STATUS = {
    incomplete: 0,
    complete: 1
  }

  def complete?
    self.status == STATUS[:complete]
  end

  def incomplete?
    self.status == STATUS[:incomplete]
  end

end
