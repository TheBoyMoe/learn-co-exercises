module ApplicationHelper

	def student_active?
		(@student.active)? 'active' : 'inactive'
	end
end
