class StudentsController < ApplicationController
	before_action :set_student, only: [:show, :edit, :update]

	def new
		@student = Student.new
	end

	def create
		# post :create, { :student => { :first_name => "Bill", :last_name => "Smith" } }
		@student = Student.new(student_params)
		if @student.save
			redirect_to student_path(@student)
		end
	end

	def index
		@students = Student.all
	end

	def show
	end

	def edit
	end

	def update
		if @student.update(student_params)
			redirect_to student_path(@student)
		end
	end

	private
		def set_student
			@student = Student.find(params[:id])
		end

		def student_params
			params.require(:student).permit(:first_name, :last_name)
		end
end