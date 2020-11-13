@students = [
  {:name => "Amelie", :cohort => "April"},
  {:name => "Anna", :cohort => "June"},
  {:name => "Delboy", :cohort => "June"},
  {:name => "Katie", :cohort => "April"}
]

# Ex2. prints students whose name begins with certain letter
def print_students_by_initial
  puts "List students whose name begins with: "
  user_input = STDIN.gets.chomp.upcase # get initial from user
  puts "Students whose name begins with '#{user_input}': "
  # iterate through students for names that start with user_input
  @students.each do |student|
    if student[:name].start_with?(user_input)
      puts student[:name]
    end
  end
end
# Ex3. prints names less than x characters
def print_students_with_names_shorter_than
  puts "Enter the maximum number of characters in a name: "
  max_length = STDIN.gets.chomp.to_i # get number as integer from user
  # iterate through students looking for names shorter than max_length
  @students.each do |student|
    if student[:name].length <= max_length
      puts student[:name]
    end
  end
end
# Ex4. print all students using while or until loop
def printloop_students
  i = 0
  while i < @students.count
    puts "#{@students[i][:name]} (#{@students[i][:cohort]} cohort)"
    i += 1
  end
end
# Ex8. display students by cohort
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

print_students_by_initial
print_students_with_names_shorter_than
printloop_students
students_by_cohort
