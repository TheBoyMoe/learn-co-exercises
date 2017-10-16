class Student < ActiveRecord::Base
  after_initialize :set_default_values

  # add 'active' column to 'students' table
  def set_default_values
    self.active ||= false
  end

  def to_s
    "#{first_name} #{last_name}"
  end

end
