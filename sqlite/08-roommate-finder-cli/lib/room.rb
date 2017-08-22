class Room
  attr_accessor :title, :date_created, :price, :url

  def self.create_from_hash(hash)
    self.new_from_hash(hash).save
  end

  def self.new_from_hash(hash)
    # return an instance from the hash
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]
    binding.pry
    room
  end

  def save
    # save the instance to the database
    puts 'saving to the database'
  end

end
