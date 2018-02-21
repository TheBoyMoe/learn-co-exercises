class UserPolicy < ApplicationPolicy

	# allows only admin access
	def index?
		user.admin?
	end

	# allows only the owner or admin to see profile
	# prevents other users from seeing your profile
	def show?
		user.admin? || user == record
	end

	# allows only admin to make updates
	def update?
		user.admin?
	end

	# allows only admins to delete the user
	def destroy?
		user.admin? || (user != record)
	end

end
