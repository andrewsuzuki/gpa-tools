require_relative "college"

class App

	def prompt()
		print ">> "
		input = gets.chomp
		print "\n"
		return input
	end

	def run()

		puts %q{
                              _____            ______       
_______ ______________ _      __  /_______________  /_______
__  __ `/__  __ \  __ `/_______  __/  __ \  __ \_  /__  ___/
_  /_/ /__  /_/ / /_/ /_/_____/ /_ / /_/ / /_/ /  / _(__  ) 
_\__, / _  .___/\__,_/        \__/ \____/\____//_/  /____/  
/____/  /_/                                                 
              by andrew suzuki
		}
	
		input = nil 

		while input != "q"
			puts "---------"
			puts "MAIN MENU"
			puts "---------"
			puts "'q' to exit"
			puts "'c' for cumulative gpa calculator"

			input = prompt()

			if input == "c"
				run_cumulative()
			elsif input == "q"
				puts "See ya!"
			else
				puts "Sorry, I didn't understand that command."
			end
		end

	end

	def run_cumulative()
		puts "------------------------"
		puts "Calculate Cumulative GPA"
		puts "------------------------"

		college = College.new

		input = nil

		while input != "q"
			puts "'q' to exit (to menu)"
			puts "'a' to add semester"
			puts "'l' to list semesters"
			puts "'d' to delete an added semester"
			puts "'c' to calculate cumulative GPA"

			input = prompt()
	
			if input == "a"
				puts "Semester GPA:"
				gpa = prompt() 
				puts "Semester Total Credit Hours:"
				hours = prompt()

				college.addSemester(gpa, hours)
			elsif input == "l"
				college.listSemesters()
			elsif input == "d"
				puts "Which semester? (Enter number)"
				college.listSemesters()
				college.deleteSemester(prompt().to_i)
			elsif input == "c"
				puts college.calculate()
			elsif input == "q"
			else
				puts "Sorry, didn't understand that command."
			end
		end
	end
end
