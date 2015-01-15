# Problem 9
# =========


#    A Pythagorean triplet is a set of three natural numbers, a < b < c, for
#    which,

#                                 a^2 + b^2 = c^2

#    For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

#    There exists exactly one Pythagorean triplet for which a + b + c = 1000.
#    Find the product abc.

   
#    Answer: 24eaa9820350012ff678de47cb85b639

defmodule Problem9 do
	

	def square(num), do: num * num

	def can_solve_pythagoras_equation(tuple) do
		{a,b,c} = tuple
		square(a) + square(b) == square(c)
	end

	def problem9_result do
		{a,b,c} = list_of_three_numbers_for_sum(1000) |> Enum.filter(fn t -> can_solve_pythagoras_equation(t)end) |> List.first
		a * b * c
	end

	def find_other_pairs(a,num) do
		(a+1..num) |> Enum.map(fn(i) -> {i,num-i} end) 
	end

	def list_of_three_numbers_for_sum(num) do
		(1..num) 
		|> Enum.map(fn(i) -> {i, num-i} end) 
		|> Enum.map(fn(j) -> {a,other} = j; find_other_pairs(a,other) |> Enum.map(fn pair -> Tuple.insert_at(pair,0,a) end) end)
		|> List.flatten
		|> Enum.filter(fn tuple -> {a,b,c} = tuple; a < b and b < c end)
	end

end

ExUnit.start

defmodule Problem9Test do

   use ExUnit.Case, async: true
   import Problem9

   test "#list_of_three_numbers_for_sum" do
   		assert list_of_three_numbers_for_sum(6) == [{1,2,3}]
   end

   test "Problem9Test" do
    result = problem9_result
    assert "24eaa9820350012ff678de47cb85b639" == :os.cmd('echo -n #{result |> Integer.to_string } | md5sum') |> List.to_string |> String.split(" ") |> List.first
    IO.puts "result is #{result}"
   end

end