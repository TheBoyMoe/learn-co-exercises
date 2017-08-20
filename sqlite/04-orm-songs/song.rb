class Song
  attr_accessor :name, :album
  attr_reader = :id

  def initialize(name, album, id = nil)
    @id = id
    @name = name
    @album = album
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.create(name:, album:)
    song = Song.new(name, album)
    song.save
    song
  end

  def self.new_from_db(row)
    self.new(row[1], row[2], row[0])
  end

  def self.all
    # returns an array of song instances
    DB[:conn].execute("SELECT * FROM songs;").map do |row|
      self.new_from_db(row)
    end
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM songs
      WHERE name = ?
      LIMIT 1
    SQL
    DB[:conn].execute(sql, name).map {|row| self.new_from_db(row)}.first
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT * FROM songs
      WHERE id = ?
    SQL
    DB[:conn].execute(sql, id).map {|row| self.new_from_db(row)}.first
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO songs (name, album)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.album)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
    end
  end

  def update
    sql = "UPDATE songs SET name = ?, album = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.album, self.id)
  end

end
