require_relative('../db/sql_runner')

class Student

attr_reader :first_name, :second_name, :house, :age

def initialize(options)
  @id = options['id'].to_i
  @first_name = options['first_name']
  @second_name = options['second_name']
  @house = options['house'].to_i
  @age = options['age'].to_i
end

def save()
  sql = "INSERT INTO students (
  first_name,
  second_name,
  house,
  age
  )
  VALUES
  ($1, $2, $3, $4)
  RETURNING *"
  values = [@first_name, @second_name, @house, @age]
  student_data = SqlRunner.run(sql, values)
  @id = student_data.first()['id'].to_i
end

def house_name()
sql = "SELECT name FROM houses WHERE id = $1"
values = [@house]
house_data = SqlRunner.run(sql, values)
return House.new(house_data)
end



##############################

# class methods below this line

##############################

def self.all()
  sql = "SELECT * FROM students"
  students_hash = SqlRunner.run(sql)
  result = students_hash.map { |student| Student.new(student) }
  return result
end

def self.find(id)
  sql = "SELECT * FROM students
  WHERE id = $1"
  values = [id]
  individual_student = SqlRunner.run(sql, values)
  result = Student.new(individual_student.first)
  return result
end

end
