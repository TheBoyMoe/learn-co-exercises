class Room
  attr_accessor :title, :date_created, :price, :url

  def self.create_from_hash(hash)
    # save each record in turn to the database
    self.new_from_hash(hash).save
  end

  def self.new_from_hash(hash)
    # return an instance from the hash
    room = self.new
    room.title = hash[:title]
    room.date_created = hash[:date_created]
    room.price = hash[:price]
    room.url = hash[:url]
    room
  end

  def save
    self.insert
  end

  def insert
    # save the instance to the database
    sql = <<-SQL
      INSERT INTO rooms (title, date_created, price, url)
      VALUES (?, ?, ?, ?)
    SQL
    DB[:conn].execute(sql, self.title, self.date_created, self.price, self.url)
  end

  # TODO
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS rooms (
        id INTEGER PRIMARY KEY,
        title TEXT,
        date_created TEXT,
        price TEXT,
        url TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

end
