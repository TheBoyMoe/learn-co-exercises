# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string
#  hometown   :string
#  birthday   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ActiveRecord::Base
  has_many :classroom_students
  has_many :classrooms, through: :classroom_students

  # def self.search(query)
  #   return Student.all if !query || query.empty?
  #   Student.all.select do |student|
  #     student if student.name.downcase.match query
  #   end
  # end

  def self.search(query)
    if query.present?
      where('NAME like ?', "%#{query}%")
    else
      self.all
    end
  end

end
