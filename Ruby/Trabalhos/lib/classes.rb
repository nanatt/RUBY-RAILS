class Shape
end
class Square < Shape
	def perimeter_of_square(side_length)
		side_length*4
	end
	def area
		side_length*side_length
	end
	def perimeter
		side_length*4
	end
end
class Triangle < Shape
	attr_accessor :base_width, :height, :side1, :side2, :hypotenuse

	def  initialize
	end
	def area
		base_width*height/2
	end
	def perimeter
		side1+side2+hypotenuse
	end
end
my_triangle = Triangle.new()

puts "What are the values from the triangle? (s1, s2, s3)"
my_triangle.side1 = gets.to_i
my_triangle.side2 = gets.to_i
my_triangle.hypotenuse = gets.to_i
puts my_triangle.perimeter