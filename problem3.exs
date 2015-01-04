# Problem 3
# =========


#    The prime factors of 13195 are 5, 7, 13 and 29.

#    What is the largest prime factor of the number 600851475143 ?


defmodule Problem3 do
	
	def prime?(2), do: true

	def prime?(n) when rem(n,2) == 0, do: false

	def prime?(n) , do: divisors(n) == [n]

	def is_divisible_by?(div,denom), do: rem(denom,div) == 0

	def divisors(n) do
		2..n |> Enum.filter(fn i -> is_divisible_by?(i,n) end)
	end

	def prime_divisors(n) do
		divisors(n) |> Enum.filter(&prime?/1)
	end

	def prime_factorize(num,base) do
		cond do
			num == base 	 -> num
			rem(num,base) == 0 and prime?(base) -> prime_factorize(div(num,base),base)
			true	 -> prime_factorize(num,base + 1)

		end
	end


	def laragest_prime_factor(n) do
		prime_divisors(n) |> Enum.max
	end

end


ExUnit.start


defmodule Problem3Test do
	
	import Problem3
	use ExUnit.Case, async: true

	test "#prime?" do
		assert prime?(2)
		assert prime?(5)
		refute prime?(4)
		assert prime?(13)
		refute prime?(15)
	end

	test "is_divisible_by" do
		assert is_divisible_by?(3,9)
	end

	test "divisors" do
		assert divisors(10) == [2,5,10]
		assert divisors(28) == [2,4,7,14,28]
	end 

	test "prime_divisors" do
		assert prime_divisors(10) == [2,5]
		assert prime_divisors(28) == [2,7]
		assert prime_divisors(29) == [29]
	end

	test "laragest_prime_factor" do
		assert prime_factorize(13195,2) == 29
	end
	IO.puts prime_factorize(600851475143,2)
end

# 1000 = 500 * 2
#      = 250 * 2 * 2
#      = 125 * 2 * 2
#      = 25 * 5 * 2 * 2
#      = 5 * 5 * 5 * 2 * 2

