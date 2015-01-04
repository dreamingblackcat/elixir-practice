# Problem 4
# =========


#    A palindromic number reads the same both ways. The largest palindrome made
#    from the product of two 2-digit numbers is 9009 = 91 × 99.

#    Find the largest palindrome made from the product of two 3-digit numbers.

   
#    Answer: d4cfc27d16ea72a96b83d9bdef6ce2ec

defmodule Problem4 do

	def palindrome?(num) do
		num == Integer.to_char_list(num) |> Enum.reverse |> List.to_string |> String.to_integer(10) 
	end
	
	def possible_nums(nums) do
		nums |> Enum.flat_map(fn i -> Enum.map nums, fn j -> [i,j,i*j] end end)
	end

	def largest_two_digit_palindrome do
		99..10 
		|> Enum.to_list |> worker

	end

	defp worker(list) do
		list
		|> possible_nums 
		|> Enum.sort(fn l1,l2 -> List.last(l1) >= List.last(l2) end)
		|> Enum.drop_while(fn lst -> [_,_,p] = lst ;!palindrome?(p) end)
		|> List.first
	end

	def largest_three_digit_palindrome do
		999..100 |> Enum.to_list |> worker
	end
end


ExUnit.start



defmodule Problem4Test do
	use ExUnit.Case, async: true

	import Problem4

	test "palindrome?" do
		assert palindrome?(1221)
		refute palindrome?(123)
	end

	test "largest palidrome of 2 digit numbers products" do
		assert largest_two_digit_palindrome == [99,91,9009]
	end

	test "Problem4Test" do
		ans = largest_three_digit_palindrome() |> List.last
		# assert [1] == 999..100 |> Enum.to_list |> worker2
		assert "d4cfc27d16ea72a96b83d9bdef6ce2ec" == :os.cmd('echo -n #{ans} | md5sum') |> List.to_string |> String.split(" ") |> List.first
	end
end