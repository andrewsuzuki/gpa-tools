class Semester

	def initialize(gpa, credits)
		@gpa = gpa.to_f
		@credits = credits.to_f
	end

	def worth
		return @gpa * @credits
	end

	attr_reader :gpa
	attr_reader :credits

end

class College

	def initialize()
		@semesters = []
	end

	def add(gpa, credits)
		sem = Semester.new(gpa, credits)
		@semesters.push(sem)
	end

	def calculate()
		worth = 0
		chours = 0

		@semesters.each do |sem|
			worth += sem.worth()
			chours += sem.credits
		end

		return worth / chours
	end

end

class App

	def run()
		puts "*******************"
		puts "** Calculate cumulative GPA based on each semester's GPA and total credit-hours."
		puts "*******************"

		college = College.new
		
		input = 0

		while input != "quit"
			puts "'quit' to quit"
			puts "'add' to add semester"
			puts "'calc' to determine cumulative GPA"

			input = gets.chomp

			if input == "add"
				puts "Semester GPA:"
				gpa = gets.chomp
				puts "Semester Total Credit Hours:"
				hours = gets.chomp

				college.add(gpa, hours)
			elsif input == "calc"
				puts college.calculate()
			elsif input == "quit"
				puts "See ya!"
			else
				puts "Sorry, didn't understand that command."
			end
		end
	end

end

app = App.new
app.run()
