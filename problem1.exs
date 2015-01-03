# Problem 1
# =========


#    If we list all the natural numbers below 10 that are multiples of 3 or 5,
#    we get 3, 5, 6 and 9. The sum of these multiples is 23.

#    Find the sum of all the multiples of 3 or 5 below 1000.

defmodule Problem1 do 
	def is_multiple_of?(div,denom), do: rem(denom, div) == 0

	def is_multiple_of_three_and_five?(num), do: is_multiple_of?(3,num) and is_multiple_of?(5,num)

	def multiples_of_three_and_five_under(num) do
		1..num |> Enum.filter(&is_multiple_of_three_and_five?/1)
	end
	def sum_of_multiples_of_three_and_five_under(num) do
		multiples_of_three_and_five_under(num) |> Enum.sum
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
	test "#is_multiple_of_three_and_five" do
		assert is_multiple_of_three_and_five?(15)
		refute is_multiple_of_three_and_five?(9)
		refute is_multiple_of_three_and_five?(20)
		refute is_multiple_of_three_and_five?(4)
	end

	test "#multiples_of_three_and_five_under 1000 should not contain non-multiples" do
		refute multiples_of_three_and_five_under(1000) |> Enum.member?(9)
		refute multiples_of_three_and_five_under(1000) |> Enum.member?(10)
	end

	test "#multiples_of_three_and_five_under 1000 should contain actual multiples" do
		assert multiples_of_three_and_five_under(1000) |> Enum.member?(15)
		assert multiples_of_three_and_five_under(1000) |> Enum.member?(30)
	end

	test "sum_of_multiples_of_three_and_five_under 1000" do
		assert sum_of_multiples_of_three_and_five_under(1000) == 33165
	end			
	IO.puts multiples_of_three_and_five_under(1000)
end