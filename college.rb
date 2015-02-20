class Semester

	def initialize(gpa, credits)
		@gpa = gpa.to_f
		@credits = credits.to_f
	end

	def worth
		@gpa * @credits
	end

	attr_reader :gpa
	attr_reader :credits

end

class College

	def initialize()
		@semesters = []
	end

	def addSemester(gpa, credits)
		sem = Semester.new(gpa, credits)
		@semesters.push(sem)
		puts "Semester " + @semesters.length.to_s + " added!"
	end
	
	def deleteSemester(number)
		if number >= 1 && number <= @semesters.length
			@semesters.delete_at(number - 1)		
			puts "Semester " + number.to_s + " deleted!"
		else
			puts "Semester " + number.to_s + " does not exist."
		end
	end

	def listSemesters()
		if @semesters.length
			i = 1

			@semesters.each do |sem|
				puts "Semester " + i.to_s + " / GPA: " + sem.gpa().to_s + " Credit-hours: " + sem.credits().to_s
				i += 1
			end
		else
			puts "No semesters have been added yet."
		end
	end

	def calculate()
		if @semesters.length == 0
			return nil
		end

		worth = 0
		chours = 0

		@semesters.each do |sem|
			worth += sem.worth()
			chours += sem.credits()
		end

		# if chours is zero, return 0. else, return cumulative gpa
		return chours ? worth / chours : 0.0
	end

end
