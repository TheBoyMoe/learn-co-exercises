class Comment
  include Persistable::InstanceMethods
  extend Persistable::ClassMethods

  ATTRIBUTES = {
    :id => 'INTEGER PRIMARY KEY',
    :user => 'TEXT',
    :content => 'TEXT'
  }

  # enables the modules to access th ATTRIBUTES hash
  def self.attributes
    ATTRIBUTES
  end

  # return the attr_accessor methods
  ATTRIBUTES.keys.each do |attribute_name|
    attr_accessor attribute_name
  end

end
