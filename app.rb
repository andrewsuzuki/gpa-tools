require_relative "college"

class App

	def prompt()
		print ">> "
		input = gets.chomp
		print "\n"
		return input
	end

	def header(text)
		border = "-" * text.length
		puts border, text, border
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
			header("Main Menu")
			puts "q: exit"
			puts "c: cumulative gpa calculator"

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
		header("Calculate Cumulative GPA")

		college = College.new

		input = nil

		while input != "q"
			puts ""
			puts "q: exit (to menu)"
			puts "a: add semester"
			puts "m: move semester"
			puts "l: list semesters"
			puts "d: delete an added semester"
			puts "c: calculate cumulative GPA"

			input = prompt()
	
			if input == "a"
				#puts ""
				#type = prompt()
				puts "Semester GPA:"
				gpa = prompt() 
				puts "Semester Total Credit Hours:"
				hours = prompt()

				begin
					college.addSemesterWithGpa(gpa, hours)
				rescue Exception => e
					puts e.message
				end
			elsif input == "l"
				college.listSemesters()
			elsif input == "d"
				puts "Which semester? (Enter number)"
				college.listSemesters()
				college.deleteSemester(prompt().to_i)
			elsif input == "m"
				puts "Which semester? (Enter number)"
				college.listSemesters()
				from = prompt().to_i
				puts "Switch with? (Enter number)"
				to = prompt().to_i
				college.moveSemester(from, to)
			elsif input == "c"
				cgpa = college.calculate()

				if cgpa == nil
					puts "You have not entered any semester GPAs yet."
				else
					puts "Cumulative GPA: " + cgpa.to_s
				end
			elsif input == "q"
			else
				puts "Sorry, didn't understand that command."
			end
		end
	end
end
