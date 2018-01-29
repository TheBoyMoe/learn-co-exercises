class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: 'Catamaran'}).uniq
  end

  # captains of sailboats
  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end

  # captains of motorboatsrps
  def self.motorboaters
    Captain.includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end

  # captains of sailboats and motorboats
  def self.talented_seamen
    Captain.where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  # not captains of sailboats
  def self.non_sailors
    Captain.where.not('id IN (?)', self.sailors.pluck(:id))
  end

end
