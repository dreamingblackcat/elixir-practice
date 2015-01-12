# Problem 6
# =========


#    The sum of the squares of the first ten natural numbers is,

#                           1^2 + 2^2 + ... + 10^2 = 385

#    The square of the sum of the first ten natural numbers is,

#                        (1 + 2 + ... + 10)^2 = 55^2 = 3025

#    Hence the difference between the sum of the squares of the first ten
#    natural numbers and the square of the sum is 3025 − 385 = 2640.

#    Find the difference between the sum of the squares of the first one
#    hundred natural numbers and the square of the sum.

   
#    Answer: 867380888952c39a131fe1d832246ecc

defmodule Problem6 do
	def sum_of_squares(list) do
		list |> Enum.reduce(&(&1 * &1 + &2))
	end

	def square_of_sum(list) do
		sum = list |> Enum.reduce(&(&1+&2)) 
		sum * sum
	end

	def difference(list) do
		square_of_sum(list) - sum_of_squares(list)
	end

end

ExUnit.start

defmodule Problem6Test do
	use ExUnit.Case, async: true

	import Problem6

	test "sum_of_squares" do
		assert sum_of_squares([1,2,3]) == 14
	end

	test "square_of_sum" do
		assert square_of_sum([1,2,3]) == 36
	end

	test "difference" do
		assert difference([1,2,3]) == 22
	end

	test "given result" do
		the_list = (1..10) |> Enum.to_list
		assert sum_of_squares(the_list) == 385
		assert square_of_sum(the_list) == 3025
		assert difference(the_list) == 2640
	end

	test "Problem6Test" do
		result = (1..100) |> Enum.to_list |> difference
		assert "867380888952c39a131fe1d832246ecc" == :os.cmd('echo -n #{result} | md5sum') |> List.to_string |> String.split(" ") |> List.first
		IO.puts "result is #{result}"
	end
end
