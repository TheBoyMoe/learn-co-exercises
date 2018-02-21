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

	# allows the admin or owner to make updates
	def update?
		user.admin?
	end

	# allows the admin to delete the user(and not their own account)
	def destroy?
		user.admin? || (user != record)
	end

end
