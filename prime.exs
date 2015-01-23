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

# IO.puts "100th prime is #{Problem7.nth_prime(100001)}" #389.6s elapsed
IO.puts "1000th prime is #{Problem7.nth_prime(1000)}" #0.7s