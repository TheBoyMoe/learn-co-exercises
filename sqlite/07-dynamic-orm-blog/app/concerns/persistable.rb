module Persistable

  module ClassMethods

    def create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS #{self.table_name} (
          #{self.create_sql}
        )
      SQL
      DB[:conn].execute(sql)
    end

    def create(attributes_hash)
      self.new.tap do |instance|
        attributes_hash.each do |attribute_name, value|
          instance.send("#{attribute_name}=", value)
        end
        instance.save
      end
    end

    # return the table_name
    def table_name
      "#{self.to_s.downcase}s"
    end

    # returns an sql string based on the ATTRIBUTES hash
    # returns #=> "id INTEGER PRIMARY KEY, title TEXT, content TEXT, author TEXT"
    def create_sql
      self.attributes.collect {|attribute_name, value| "#{attribute_name} #{value}"}.join(', ')
    end

    # returns an instance of Post from record
    def instance_from_row(row)
      # return new post instance
      self.new.tap do |post|
        self.attributes.keys.each.with_index do |attribute_name, i|
          post.send("#{attribute_name}=", row[i])
        end
      end
    end

    def find_by_id(id)
      sql = <<-SQL
        SELECT * FROM #{self.table_name}
        WHERE id = ?
      SQL
      DB[:conn].execute(sql, id).map {|row| self.instance_from_row(row)}.first
    end

    # iterate through ATTRIBUTES, return attribute names except id
    # returns #=> "title, content, author"
    def attribute_names_for_insert
      self.attributes.keys[1..-1].join(', ')
    end

    # returns a string with a '?' for each attribute name
    # returns #=> "?, ?, ?"
    def question_marks_for_insert
      (self.attributes.size - 1).times.collect{'?'}.join(', ')
    end

    # returns #=> "title = ?, content = ?, author = ?"
    def attribute_names_for_update
      self.attributes.keys[1..-1].collect {|attribute_name| "#{attribute_name} = ?"}.join(', ')
    end

  end

  module InstanceMethods

    # returns an array of attribute value, all except for id
    # returns #=> ["title", "content", "author"]
    def attribute_values
      self.class.attributes.keys[1..-1].collect {|attribute_name| self.send(attribute_name)}
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

    def delete
      sql = "DELETE FROM #{self.class.table_name} WHERE id = ?"
      DB[:conn].execute(sql, self.id)
    end

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

end
