class Team
  attr_accessor :name, :students
  def initialize(name)
    @name = name
    @students = []
  end
  def add_student(id_number, first_name, last_name)
    student = Student.new
    student.id_number  = id_number
    student.first_name = first_name
    student.last_name  = last_name
    @students << student
  end
  def print_students
    @students.each do |student|
      puts student.full_name
    end
  end 
end
  class Student
    attr_accessor :first_name, :last_name, :id_number
  def full_name
    last_name + ", " + first_name
  end 
end

team = Team.new("Rowing")
team.add_student(1982, "John", "Smith")
team.add_student(1984, "Bob", "Jones")
team.print_students
