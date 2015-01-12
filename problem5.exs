# Problem 5
# =========


#    2520 is the smallest number that can be divided by each of the numbers
#    from 1 to 10 without any remainder.

#    What is the smallest positive number that is evenly divisible by all of
#    the numbers from 1 to 20?

   
#    Answer: bc0d0a22a7a46212135ed0ba77d22f3a


defmodule Problem5 do

	def biggest_factors(list) do
		sanitize list, (list |> List.last)
	end

	defp sanitize([],_), do: []
	defp sanitize(list,num) do
		[h | t] = list |> Enum.reverse
		lst = t |> Enum.reject(fn j -> rem(num,j) == 0 end) |>Enum.reverse
		[h] ++ sanitize(lst, lst |> List.last)
	end

	def given_for_problem5 do
		(1..10) |> Enum.to_list |> biggest_factors |> find_smallest_common_multiple
	end

	def result_of_problem5 do
		(1..20) |> Enum.to_list |> biggest_factors |> find_smallest_common_multiple
	end

	def find_smallest_common_multiple(list) do
		initial_value = hd(list)
		worker(initial_value,list)
	end

	def worker(num,list) do
		[h|t] = list
		cond do
			rem(num,h) == 0 and test_for_tail(num,t) -> num
			true 			-> IO.puts num
							   worker(num+h,list)
		end
	end

	def test_for_tail(num,list) do
		cond do
			list == [] 												-> true
			rem(num,hd(list)) == 0 and test_for_tail(num,tl(list))  -> true
			true													-> false
		end	
	end
	
end

ExUnit.start

defmodule Problem5Test do
	use ExUnit.Case, async: true

	import Problem5

	test "biggest_factors" do
		assert biggest_factors([2,4,20]) == [20]
		assert biggest_factors([3,9,18,19]) == [19,18]
		assert biggest_factors((1..20) |> Enum.to_list) == [20, 19, 18, 17, 16, 15, 14, 13, 12, 11]
	end

	test "correct for given fact" do
		assert given_for_problem5 == 2520
	end

	# test "Problem5Test" do
	# 	result = result_of_problem5
	# 	assert "bc0d0a22a7a46212135ed0ba77d22f3a" == :os.cmd('echo -n #{result} | md5sum') |> List.to_string |> String.split(" ") |> List.first
	# 	IO.puts "result is #{result}"
	# end
		IO.puts "result is #{result_of_problem5}"
end
