# Problem 7
# =========


#    By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
#    that the 6th prime is 13.

#    What is the 10 001st prime number?

   
#    Answer: 8c32ab09ec0210af60d392e9b2009560
#    ans: 104743
defmodule Problem7 do

	def prime_test?(tuple) do
		{n,list} = tuple
		cond do
			list == []            -> true         
			rem(n, hd(list)) == 0 -> false
			hd(list) * 2 > n      -> true    
			true                  -> prime_test?({n, tl(list)})
		end
	end

	def nth_prime(1), do: 2

	def nth_prime(n) do
		next_prime([2],3,n)
	end

	def next_prime(done,last,target) do
		current_is_prime = prime_test?({last,done})
		cond do
			done |> Enum.count == target -> done |> List.last
			current_is_prime -> next_prime(done ++ [last],last+2,target)

			!current_is_prime -> next_prime(done,last+2,target)
		end
	end
end

ExUnit.start

defmodule Problem7Test do

	use ExUnit.Case, async: true
	import Problem7
	test "prime test is correct" do
		assert prime_test?({5,[2,3]})
	end
	test "given sixth prime is correct" do
		assert nth_prime(6) == 13
	end
	test "Problem7Test" do
		result = nth_prime(10001)
		assert "8c32ab09ec0210af60d392e9b2009560" == :os.cmd('echo -n #{result} | md5sum') |> List.to_string |> String.split(" ") |> List.first
		IO.puts "result is #{result}"
	end

end