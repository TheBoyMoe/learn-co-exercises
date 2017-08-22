class Room
  attr_accessor :id, :title, :date_created, :price, :url

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

  def self.new_from_db(row)
    self.new.tap do |room|
      room.id = row[0]
      room.title = row[1]
      room.date_created = row[2]
      room.price = row[3]
      room.url = row[4]
    end
  end

  # return an array of instances from an array of records
  def self.new_from_rows(rows)
    rows.collect do |row|
      self.new_from_db(row)
    end
  end

  def self.sort_by_price(order = 'ASC')
    # sorting by price using ruby
    # case order
    # when 'ASC'
    #   self.all.sort_by {|instance| instance.price}
    # when 'DESC'
    #   self.all.sort_by {|instance| instance.price}.reverse
    # end
    rows = DB[:conn].execute("SELECT * FROM rooms ORDER BY price #{order}")
    new_from_rows(rows)
  end

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

  # return an array of instances
  def self.all
    rows = DB[:conn].execute("SELECT * FROM rooms")
    self.new_from_rows(rows)
  end


end
