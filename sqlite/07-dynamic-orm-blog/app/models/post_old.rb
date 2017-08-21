class PostOld
  attr_accessor :title, :content
  attr_reader :id

  # return the table_name
  def self.table_name
    "#{self.to_s.downcase}s"
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS #{self.table_name} (
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.instance_from_row(row)
    # return new post instance
    self.new.tap do |post|
      post.id = row[0]
      post.title = row[1]
      post.content = row[2]
    end
  end

  def self.find(id)
    sql = <<-SQL
      SELECT * FROM #{self.table_name}
      WHERE id = ?
    SQL
    DB[:conn].execute(sql, id).map {|row| self.instance_from_row(row)}.first
  end

  # check for equality
  def ==(other_post)
    self.id == other_post.id
  end

  def save
    # if the instance has not been saved, insert into database
    # otherwise update the database record
    persisted? ? update : insert
  end

  def persisted?
    # return boolean
    !!self.id
  end
  private
    def insert
      sql = <<-SQL
      INSERT INTO #{self.class.table_name} (title, content)
      VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.title, self.content)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{self.class.table_name}")[0][0]
    end

    def update
      sql = <<-SQL
        UPDATE #{self.class.table_name}
        SET title = ?, content = ?
        WHERE id = ?
      SQL
      DB[:conn].execute(sql, self.title, self.content, self.id)
      "record updated!"
    end

end
