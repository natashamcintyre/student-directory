@students = [] # empty array accessible to all methods
# add an interactive menu
def print_menu
  puts "1. Input students"
  puts "2. Show the students"
  puts "3. Save list to students.csv"
  puts "4. Load list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu # give user options and ask for input
    process(STDIN.gets.chomp)
  end
end

def process(selection)
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
  :January, :February, :March, :April, :May, :June,
  :July, :August, :September, :October, :November, :December
]

# get list of students from user
def input_students
  puts "Please enter the name and cohort of each student"
  puts "To finish, just hit return twice"
  puts "Student name: "
  # get the first name
  name = STDIN.gets.chomp.split.map(&:capitalize).join(' ')
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get student cohort
    puts "#{name}'s cohort: (or hit return to default to November)"
    cohort = STDIN.gets.chomp.capitalize.to_sym
    if cohort.empty?
      cohort = :November
    else
      while !COHORT.include?(cohort)
        puts "#{name}'s cohort: (or hit return to default to November)"
        cohort = STDIN.gets.chomp.capitalize.to_sym
      end
    end
    # add the student hash to the array
    @students << {
      name: name,
      cohort: cohort,
      hobbies: :reading,
      country: :UK,
      DOB: :unknown
    }
    # 9. edit statement to change for singular or plural
    if @students.count == 1
      $collective = "student"
    else
      $collective = "students"
    end
    puts "Now we have #{@students.count} #{$collective}"
    # get another name from the user
    puts "Student name: "
    name = STDIN.gets.chomp.split.map(&:capitalize).join(' ')
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
  puts $title1
  # 6. use center to improve output presentation
  puts "-------------".center($title1.length)
end
# Ex1. show students with number in front of name
def print_students
  if @students.size > 0
    @students.each_with_index do |student,index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center($title1.length)
    end
  else
    puts "0 students"
  end
end
# footer for show students
def print_footer
  puts "Overall, we have #{@students.count} great #{$collective}"
end

# 3. save students to file for future ref
def save_students
  # open a file
  file = File.open("students.csv", "w")
  # iterate over students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  puts "#{@students.count} students saved to students.csv"
  file.close
end

# 4. load students
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line| # readlines creates array of file's lines
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  puts "Loaded #{@students.count} students from students.csv"
  file.close
end

# On startup, check for student list arg entered in commandline
def try_to_load_students
  filename = ARGV.first # this is the first argument from the command line
  return if filename.nil? # get out of the method if not given - then auto loads
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_to_load_students
interactive_menu
