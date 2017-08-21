class Post
  attr_accessor :id, :title, :content

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

  def self.find(id)
    sql = <<-SQL
      SELECT * FROM #{self.table_name}
      WHERE id = ?
    SQL
    DB[:conn].execute(sql, id)
  end

  def save
    if self.id == nil
      sql = <<-SQL
      INSERT INTO #{self.class.table_name} (title, content)
      VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.title, self.content)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{self.class.table_name}")[0][0]
    end
  end
end
