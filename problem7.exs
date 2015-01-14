# Problem 7
# =========


#    By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
#    that the 6th prime is 13.

#    What is the 10 001st prime number?

   
#    Answer: 8c32ab09ec0210af60d392e9b2009560
#    ans: 104743
#    took too long to test with ExUnit
defmodule Problem7 do

	def ten_thousand_first_prime do
		nth_prime(10001)
	end
	
	def sixth_prime do
		nth_prime(6)
	end

	def prime?(2), do: true

	def prime?(n) when rem(n,2) == 0, do: false

	def prime?(n) , do: divisors(n) == [n]

	def divisors(n) do
		:lists.seq(3,n,2) |> Enum.filter(fn i -> rem(n,i) == 0 end)
	end

	def nth_prime(1) do
		2
	end

	def nth_prime(n) do
		Stream.iterate(3,&(find_prime/1)) |> Enum.take(n-1) |> List.last
	end

	def find_prime(num) do
		cond do
			prime?(num+2) -> IO.puts num+2
								num+2
			!prime?(num+2) -> find_prime(num+2)
		end
	end
end

ExUnit.start

defmodule Problem7Test do

	use ExUnit.Case, async: true
	import Problem7
	
	test "given sixth prime is correct" do
		assert sixth_prime == 13
	end
	# test "Problem7Test" do
	# 	result = ten_thousand_first_prime()
	# 	assert "8c32ab09ec0210af60d392e9b2009560" == :os.cmd('echo -n #{result} | md5sum') |> List.to_string |> String.split(" ") |> List.first
	# 	IO.puts "result is #{result}"
	# end
	IO.puts ten_thousand_first_prime()

end