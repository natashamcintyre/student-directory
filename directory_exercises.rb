# cohort list - fixed
COHORT = [
  :January, :February, :March, :April, :May, :June,
  :July, :August, :September, :October, :November, :December
]
@students = []
# get list of students from user
def input_students
  puts "Please enter the name and cohort of each student"
  puts "To finish, just hit return twice"
  puts "Student name: "
  # get the first name
  name = gets.chomp.split.map(&:capitalize).join(' ')
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get student cohort
    puts "#{name}'s cohort: (or hit return to default to November)"
    cohort = gets.chomp.capitalize.to_sym
    if cohort.empty?
      cohort = :November
    else
      while !COHORT.include?(cohort)
        puts "#{name}'s cohort: (or hit return to default to November)"
        cohort = gets.chomp.capitalize.to_sym
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
    name = gets.chomp.split.map(&:capitalize).join(' ')
  end
end
# print student summary
def print_header
  $title1 = "The students of Villains Academy"
  puts $title1
  # 6. use center to improve output presentation
  puts "-------------".center($title1.length)
end
def print_footer
  puts "Overall, we have #{@students.count} great #{$collective}"
end

# 1. print students with number in front of name
def print_students
  if @students.size > 0
    @students.each_with_index do |student,index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)".center($title1.length)
    end
  else
    puts "0 students"
  end
end
# 2. prints students whose name begins with certain letter
def print_initial_students
  puts "List students whose name begins with: "
  user_input = gets.chomp
  puts "Students whose name begins with '#{user_input}': "
  @students.each do |student|
    if student[:name].start_with?(user_input)
      puts student[:name]
    end
  end
end
# 3. prints names less than x characters
def print_short_students
  puts "Find names shorter than how many characters?"
  max_length = gets.chomp.to_i
  @students.each do |student|
    if student[:name].length <= max_length
      puts student[:name]
    end
  end
end
# 4. print all students using while or until loop
def printloop_students
  i = 0
  while i < @students.count
    puts "#{@students[i][:name]} (#{@students[i][:cohort]} cohort)".center($title1.length)
    i += 1
  end
end
# 8. display students by cohort
def students_by_cohort
  # new hash for existing cohorts
  by_cohort = {}
  # go through students hash and get list of existing cohorts
  @students.each do |student|
    cohort = student[:cohort]
    # check to see if cohort is in hash
    if by_cohort[cohort] == nil
      by_cohort[cohort] = []
    end
    # push student into appropriate array
    by_cohort[cohort].push(student[:name])
  end
  puts by_cohort.to_a
end
# Trying to do students by cohort using #inject
# I'm not sure it works!
# def students_by_cohort_the_inject_way(student)
#   puts (
#     student.inject([]) do |cohorts_list, (key, value)|
#       cohorts_list << value if key == :cohort
#       cohorts_list
#     end
#   )
# end
# add an interactive menu
def print_menu
  puts "1. Input students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students
  print_footer
end

def interactive_menu
  loop do
    print_menu # give user options and ask for input
    selection = gets.chomp
    case selection
      when "1"
        input_students
      when "2"
        show_students
      when "9"
        exit # program terminates
      else
        puts "I don't know what you meant, try again"
    end
  end

end

interactive_menu
# students_by_cohort_the_inject_way(student)





# print_short(students)
# printloop(students)
# students_by_cohort(students)
