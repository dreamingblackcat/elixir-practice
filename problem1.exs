# Problem 1
# =========


#    If we list all the natural numbers below 10 that are multiples of 3 or 5,
#    we get 3, 5, 6 and 9. The sum of these multiples is 23.

#    Find the sum of all the multiples of 3 or 5 below 1000.

   # Answer: e1edf9d1967ca96767dcc2b2d6df69f4


defmodule Problem1 do 
	def is_multiple_of?(div,denom), do: rem(denom, div) == 0

	def is_multiple_of_three?(num), do: is_multiple_of?(3,num)

	def is_multiple_of_five?(num), do: is_multiple_of?(5,num)

	def is_multiple_of_three_or_five?(num), do: is_multiple_of_three?(num) or is_multiple_of_five?(num)

	def multiples_of_three_or_five_under(num) do
		#use erlang stdlib function for genrating a list grown by step 5
		(1..999) |> Enum.filter(&is_multiple_of_three_or_five?/1)
	end

	def sum_of_multiples_of_three_or_five_under(num) do
		multiples_of_three_or_five_under(num) |> Enum.sum
	end
	
	
end


# 1) Start ExUnit.
ExUnit.start

# 2) Create a new test module (test case) and use [`ExUnit.Case`](ExUnit.Case.html).
defmodule Problem1Test do
  # 3) Notice we pass `async: true`, this runs the test case
  #    concurrently with other test cases
  use ExUnit.Case, async: true
  import Problem1
  # 4) Use the `test` macro instead of `def` for clarity.
    test "#is_multiple_of?" do
    	assert is_multiple_of?(2,14)
    	refute is_multiple_of?(2,15)
    end
	test "#is_multiple_of_three_or_five" do
		assert is_multiple_of_three_or_five?(15)
		assert is_multiple_of_three_or_five?(9)
		assert is_multiple_of_three_or_five?(20)
		refute is_multiple_of_three_or_five?(4)
	end

	test "#multiples_of_three_or_five_under 1000 should not contain non-multiples" do
		assert multiples_of_three_or_five_under(1000) |> Enum.member?(9)
		assert multiples_of_three_or_five_under(1000) |> Enum.member?(10)
	end

	test "#multiples_of_three_or_five_under 1000 should contain actual multiples" do
		assert multiples_of_three_or_five_under(1000) |> Enum.member?(15)
		assert multiples_of_three_or_five_under(1000) |> Enum.member?(30)
	end

	test "sum_of_multiples_of_three_or_five_under 1000" do
		assert sum_of_multiples_of_three_or_five_under(1000) == 233168
	end			

	test "Problem1Test" do
		result = sum_of_multiples_of_three_or_five_under(1000)
		assert "e1edf9d1967ca96767dcc2b2d6df69f4" == :os.cmd('echo -n #{result} | md5sum') |> List.to_string |> String.split(" ") |> List.first
		IO.puts "Anser is #{result}"
	end
end