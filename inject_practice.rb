students = [
  {
    name: "Amelia",
    cohort: :November,
    hobbies: :reading,
    country: :UK,
    DOB: :April
  },
  {
    name: "Laura",
    cohort: :October,
    hobbies: :reading,
    country: :UK,
    DOB: :April
  }
]


def students_by_cohort_the_inject_way(students)
  by_cohort = []
    students.each do |student|
      student.inject([]) do |cohorts_list, (key, value)|
        if key == :cohort
          cohorts_list << value
        end
        by_cohort << cohorts_list
      end
    end
  p by_cohort
end

students_by_cohort_the_inject_way(students)
