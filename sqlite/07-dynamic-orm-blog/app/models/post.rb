class Post

  ATTRIBUTES = {
    :id => 'INTEGER PRIMARY KEY',
    :title => 'TEXT',
    :content => 'TEXT',
    :author => 'TEXT'
  }

  # return the attr_accessor methods
  ATTRIBUTES.keys.each do |attribute_name|
    attr_accessor attribute_name
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS #{self.table_name} (
        #{self.create_sql}
      )
    SQL
    DB[:conn].execute(sql)
  end

  # return the table_name
  def self.table_name
    "#{self.to_s.downcase}s"
  end

  # returns an sql string based on the ATTRIBUTES hash
  # returns #=> "id INTEGER PRIMARY KEY, title TEXT, content TEXT, author TEXT"
  def self.create_sql
    ATTRIBUTES.collect {|attribute_name, value| "#{attribute_name} #{value}"}.join(', ')
  end

  # returns an instance of Post from record
  def self.instance_from_row(row)
    # return new post instance
    self.new.tap do |post|
      ATTRIBUTES.keys.each.with_index do |attribute_name, i|
        post.send("#{attribute_name}=", row[i])
      end
    end
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT * FROM #{self.table_name}
      WHERE id = ?
    SQL
    DB[:conn].execute(sql, id).map {|row| self.instance_from_row(row)}.first
  end

  # iterate through ATTRIBUTES, return attribute names except id
  # returns #=> "title, content, author"
  def self.attribute_names_for_insert
    ATTRIBUTES.keys[1..-1].join(', ')
  end

  # returns a string with a '?' for each attribute name
  # returns #=> "?, ?, ?"
  def self.question_marks_for_insert
    (ATTRIBUTES.size - 1).times.collect{'?'}.join(', ')
  end

  # returns an array of attribute value, all except for id
  # returns #=> ["title", "content", "author"]
  def attribute_values
    ATTRIBUTES.keys[1..-1].collect {|attribute_name| self.send(attribute_name)}
  end

  # returns #=> "title = ?, content = ?, author = ?"
  def self.attribute_names_for_update
    ATTRIBUTES.keys[1..-1].collect {|attribute_name| "#{attribute_name} = ?"}.join(', ')
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
        INSERT INTO #{self.class.table_name} (#{self.class.attribute_names_for_insert})
        VALUES (#{self.class.question_marks_for_insert})
      SQL
      DB[:conn].execute(sql, *self.attribute_values )
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{self.class.table_name}")[0][0]
    end

    def update
      sql = <<-SQL
        UPDATE #{self.class.table_name}
        SET #{self.class.attribute_names_for_update}
        WHERE id = ?
      SQL
      DB[:conn].execute(sql, *self.attribute_values, self.id)
      "record updated!"
    end

end
