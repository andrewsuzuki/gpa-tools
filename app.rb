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

	def handleError(lamb)
		begin
			lamb.call
		rescue Exception => e
			puts "Error: " + e.message
		end
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
	
		college = College.new

		input = nil

		while input != "q"
			puts ""
			puts "q: quit"
			puts "a: add semester"
			puts "m: move semester"
			puts "l: list semesters"
			puts "d: delete semester"
			puts "c: calculate cumulative GPA"

			input = prompt()
	
			if input == "a"
				puts "Semester GPA:"
				gpa = prompt() 
				puts "Semester Total Credit Hours:"
				hours = prompt()

				handleError(lambda { college.addSemesterWithGpa(gpa, hours) })
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
				
				# move semester and handle errors
				handleError(lambda { college.moveSemester(from, to) })

				college.listSemesters()
			elsif input == "c"
				unless (cgpa = college.calculate()).nil?
					puts "Cumulative GPA: " + cgpa.to_s
				else
					puts "You have not entered any semester GPAs yet."
				end
			elsif input == "q"
				puts "See ya!"
			else
				puts "Sorry, didn't understand that command."
			end
		end
	end
end
