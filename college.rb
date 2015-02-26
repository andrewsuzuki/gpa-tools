class Grade
	attr_reader :gpa

	def initialize(grade=nil, letterGrades=nil)
		if letterGrades == nil
			letterGrades = {
				"A+" => 4.0,
				"A"  => 4.0,
				"A-" =>	3.7,
				"B+" => 3.3,
				"B"  => 3.0,
				"B-" => 2.7,
				"C+" => 2.3,
				"C"  => 2.0,
				"C-" => 1.7,
				"D+" => 1.3,
				"D"  => 1.0,
				"D-" => 0.7,
				"F"  => 0.0,
				"P"  => nil 
			}
		end

		@letterGrades = letterGrades

		if grade.nil? then grade = 0.0 end # set nil grade to 0.0 default
		set(grade) # parse grade and set @gpa
	end

	def set(grade)
		@gpa = convertGradeToGpa(grade)
	end

	def gpa?(grade)
		gradeFloat = grade.to_f
		gradeFloat.to_s == grade && gradeFloat.between?(0,4) 
	end

	def percent?(grade)
		grade[-1] == "%" && grade[0..-2] == grade.tr('^0-9.', '')
	end

	def letter?(grade)
		@letterGrades.key?(grade.upcase)
	end

	def to_gpa()
		@gpa.to_s
	end

	def to_percent()
		((@gpa + 1) * 20).to_s
	end

	def to_letter()
		@letterGrades.each do |letter, gpa|
			next if @gpa < gpa
			return letter
		end
	end

	def determineType(grade)
		if gpa?(grade)
			return "gpa"
		elsif percent?(grade)
			return "percent"
		elsif letter?(grade) 
			return "letter"
		end

		raise ArgumentError.new("Invalid grade.")
	end

	def convertGradeToGpa(grade)
		# if grade is already an instance of Grade, return its gpa value
		if grade.is_a? Grade then return grade.gpa end

		grade = grade.to_s.upcase # force to string uppercase

		type = determineType(grade)

		case type
		when "gpa"
			return grade.to_f
		when "percent"
			return (gpa[0..-2].to_f / 20) - 1
		when "letter"
			return @letterGrades[grade]
		end
	end
end

class Course
	attr_reader :grade, :credits

	def initialize(grade, credits)
		@grade = Grade.new(grade)
		@credits = credits.to_f
	end

	def weight
		@grade * @credits
	end
end

class Semester
	attr_reader :courses, :gpa, :credits

	def initialize(gpa = nil, credits = nil)
		@courses = []
		@gpa = Grade.new()
		@credits = 0.0

		unless credits.nil?	
			if gpa.is_a? Grade
				@gpa = gpa
			elsif gpa.is_a? String
				@gpa = Grade.new(gpa)
			else
				return
			end

			@credits = credits.to_f
			return
		end
	end

	def setGrade(grade)
		@gpa = Grade.new(gpa)
	end

	def addCourse(grade, credits)
		@courses.push(Course.new(grade, credits))
		@courses.each do |course|
			total 
		end
	end

	def weight
		@gpa.gpa * @credits
	end
end

class College
	def initialize()
		@semesters = []
	end

	def countSemesters()
		@semesters.length
	end

	def has_semesters?()
		@semesters.length != 0
	end

	# Checks if semester n exists (ordinal)
	def semesterExists(n)
		n.is_a?(Integer) && n >= 1 && n <= @semesters.length
	end

	def addSemester(semester)
		@semesters.push(semester)
		puts "Semester " + countSemesters().to_s + " added!"
	end

	def addSemesterWithGpa(gpa, credits)
		sem = Semester.new(gpa, credits)
		addSemester(sem)
	end
	
	def addSemesterWithCourses(courses)
		sem = Semester.new()
		courses.each do |courses|
			sem.addCourse(course[0], course[1])
		end
		addSemester(sem)
	end

	# Moves semester by position (ordinal)
	def moveSemester(from, to)
		if semesterExists(from) && semesterExists(to)
			@semesters.insert(to-1, @semesters.delete_at(from-1))
		else
			raise ArgumentError.new("Invalid semester number(s)")
		end
	end

	# Deletes semester n (ordinal)
	def deleteSemester(n)
		if semesterExists(n) 
			@semesters.delete_at(n - 1)		
			puts "Semester " + n.to_s + " deleted!"
		else
			puts "Semester " + n.to_s + " does not exist."
		end
	end

	def listSemesters()
		if has_semesters?()
			@semesters.each_with_index do |sem, i|
				puts "Semester " + (i + 1).to_s + " / GPA: " + sem.gpa().gpa.to_s + ", Credit-hours: " + sem.credits().to_s
			end
		else
			puts "No semesters have been added yet."
		end
	end

	def calculate()
		unless has_semesters?() then return nil end

		weight = 0
		chours = 0

		@semesters.each do |sem|
			weight += sem.weight()
			chours += sem.credits()
		end

		# if chours is zero, return 0. else, return cumulative gpa
		chours ? weight / chours : 0.0
	end
end
