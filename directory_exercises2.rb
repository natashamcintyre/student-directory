require 'csv'
@students = [] # empty array accessible to all methods

# add an interactive menu
def print_menu
  puts "1. Input students"
  puts "2. Show the students"
  puts "3. Save list"
  puts "4. Load list"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu # give user options and ask for input
    get_option(STDIN.gets.chomp)
  end
end

def get_option(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # program terminates
    else
      puts "I don't know what you meant, try again"
  end
end

# 1. input students
# cohort list - fixed
COHORT = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
]

# get list of students from user
def input_students
  puts "Please enter the name and cohort of each student"
  puts "To finish, just hit return twice"
  while !get_student_name.empty?
    get_student_cohort
    add_student(@student_name, @student_cohort, "count")
  end
end

def get_student_name
  puts "Student name: "
  @student_name = STDIN.gets.chomp.split.map(&:capitalize).join(' ')
end

def get_student_cohort
  loop do
    puts "#{@student_name}'s cohort: (or hit return to default to November)"
    @student_cohort = STDIN.gets.chomp.capitalize
    if @student_cohort.empty? # default to November
      return @student_cohort = :November
    elsif !COHORT.include?(@student_cohort) # if typo
      puts "Sorry I didn't catch that. Please try again."
    else
      return @student_cohort
    end
  end
end

def add_student(name, cohort, count = nil)
  @students << {name: name, cohort: cohort.to_sym}
  if !count.nil?
    puts "Now we have #{@students.count} #{collective}"
  end
end

def collective
  if @students.count == 1
    "student"
  else
    "students"
  end
end

# 2. Show students
def show_students
  print_header
  print_students
  print_footer
end
# header for show students
def print_header
  $title1 = "The students of Villains Academy"
  puts "\n#{$title1}"
  # 6. use center to improve output presentation
  puts "-------------".center($title1.length)
end
# Ex1. show students with number in front of name
def print_students
  if @students.size > 0
    @students.each_with_index do |student,index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  else
    puts "0 students"
  end
end
# footer for show students
def print_footer
  puts "-------------".center($title1.length)
  puts "Overall, we have #{@students.count} great #{collective}."
  puts
end

# 3. save students to file for future ref
def save_students
  puts "Save as: "
  filename = STDIN.gets.chomp
  # use csv library to write to file
  CSV.open(filename, "wb") do |file|
    # iterate over students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      file << student_data
    end
  end
  puts "#{@students.count} students saved to #{filename}"
  puts
end

# 4. load students
def load_students(filename = "ask")
  if filename == "ask"
    puts "Which file would you like to load?"
    filename = STDIN.gets.chomp
  end
  CSV.foreach(filename) do |line| # readlines creates array of file's lines
    name, cohort = line[0], line[1]
    add_student(name, cohort)
  end
  puts "Loaded #{CSV.read(filename).size} students from #{filename}"
  puts
end

# On startup, check for student list arg entered in commandline
def try_to_load_students
  filename = ARGV.first # this is the first argument from the command line
  if filename.nil?
    puts "Load students from students.csv? Y/N"
    user_response = gets.chomp.upcase
    if user_response == "Y"
      load_students("students.csv")
      return
    else
      return # get out of the method if load not required
    end
  end
  if File.exist?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_to_load_students
interactive_menu
